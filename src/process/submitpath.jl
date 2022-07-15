# 路径搜索与标准格式生成

### 提交形式 ###

"四元组 => 提交形式"
function triple2link(raw_triple)
    lang, sub, rel, obj = raw_triple
    if lang == "en"
        "<http://dbpedia.org/resource/$sub>#" * 
        "<http://dbpedia.org/property/$rel>#" *
        "<http://dbpedia.org/resource/$obj>"
    elseif lang == "zh"
        "<http://zh.dbpedia.org/resource/$sub>#" * 
        "<http://zh.dbpedia.org/property/$rel>#" *
        "<http://zh.dbpedia.org/resource/$obj>"
    else
        throw("格式错误")
    end
end

"四元组路径 => 提交形式"
submit_format(triples) = join(triple2link.(triples), '#')

### 搜索路径 ###

"""
    find_paths(ner, rels, edges)

寻找从 ner 出发以 rels 为关系的子图，返回若干三元组路径 | 不做路径推理
"""
function find_paths(ner, rels, edges)
    isempty(rels) && return []
    paths = [[(ner, "", ner)]] # 初始路径
    for rel in rels, _ in eachindex(paths)
        newpath = popfirst!(paths)
        ner = newpath[end][end] # 取路径终点
        for (newrel, obj) in edges[ner]
            newrel == rel && push!(paths, vcat(newpath, (ner, newrel, obj)))
        end
    end
    popfirst!.(paths) # 去除路径的初始节点（平凡）
    paths
end


"""三元组路径 => 有效的四元组路径"""
function valid_path(newpath, dict)
    newpath = getindex.(Ref(dict), newpath) # 转化格式
    paths = [popfirst!(newpath)]
    for triples in newpath, _ in eachindex(paths)
        p = popfirst!(paths)
        for triple in triples
            push!(paths, vcat(p, [triple]))
        end
    end
    filter!(i->length(unique!(first.(i)))> 1, paths)
end

"""提交精确匹配"""
precise_submit(ner, rels, data) = submit_format.(
    vcat(valid_path.(find_paths(ner, rels, data.ills_edges), Ref(data.triple_ills2raw))...))

"""
    find_vague_paths(ner, rels, triples; best=2)

推理对齐实体
"""
function find_vague_paths(ner, rels, triples; best = 2)
    # 跳数不够
    length(rels) == 1 && return [] # 只有一跳
    # 第一跳精确匹配
    tri1s = filter(i->i[1]==ner && i[2]==rels[1], triples)
    # isempty(tri1s) && return [] # 找不到，返回无解
    isempty(tri1s) && (tri1s = filter(i->i[1]==ner, triples)) # 找不到，更换关系
    tri1 = tri1s[1] # 随机取一个
    # 第二跳模糊匹配
    possible = filter(i->i[2]==rels[2], triples)
    # 字符匹配最佳的 best 个
    tri2s = possible[nearby(first.(possible), tri1[3]; char=false, best=best, index=true)]
    length(rels) == 2 && return [[tri1, tri] for tri in tri2s]
    # 第三跳模糊匹配
    possible = filter(i->i[2]==rels[3], triples)
    paths = []
    for tri2 in tri2s
        # 只考虑最近的两个
        for tri3 in possible[nearby(first.(possible), tri2[3], char=false, best=2, index=true)]
            push!(paths, [tri1, tri2, tri3])
        end
    end
    paths
end

"""提交模糊匹配"""
vague_submit(ner, rels, triples, dict;best=2) = submit_format.(
    vcat(valid_path.(find_vague_paths(ner, rels, triples;best=best), Ref(dict))...))