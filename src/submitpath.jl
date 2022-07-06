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