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

"""三元组路径 => 有效的四元组路径"""
function valid_path(newpath, dict)
    steps = getindex.(Ref(dict), newpath) # 转化格式 [[t11, t12...], [t21, t22...]...]
    prepaths = [[step] for step in popfirst!(steps)] # 已走过的路径
    for nextsteps in steps, _ in eachindex(prepaths)
        pre = popfirst!(prepaths)
        for triple in nextsteps
            push!(prepaths, vcat(pre, [triple]))
        end
    end
    filter!(i->length(unique!(first.(i))) > 1, prepaths)
end

### 搜索精确路径 ###

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

"""获取精确匹配"""
precise_submit(ner, rels, data) = submit_format.(
    vcat(valid_path.(find_paths(ner, rels, data.ills_edges), Ref(data.triple_ills2raw))...))



### 模糊路径 ###

"""
    vague_triples(start, rel, illsdata)

匹配以 start 为起点 rel 为关系的三元组，其中 start 用模糊匹配
"""
function vague_triples(start, rel, illsdata)
    equivs = illsdata.equivILLs
    getdefault(word) = isempty(equivs[word]) ? [word] : equivs[word]
    # 以 rel 为关系的三元组
    tris = filter(i->i[2] == rel, illsdata.ills_triples)
    subs, n = first.(tris), length(tris)
    starts = getdefault(start) # 字串集
    worddists = [dist(starts, getdefault(sub)) for sub in subs]
    tris[sort(1:n; by=i->(worddists[i], -length(split(subs[i], '_'))))][1:min(2, n)] # 取最佳的 2 个
end

"""
    find_vague_paths(ner, rels, illsdata)

推理对齐实体
"""
function find_vague_paths(ner, rels, illsdata)
    length(rels) ≤ 1 && return [] # 只有一跳
    paths = [[tri] for tri in illsdata.ills_triples if tri[1]==ner && tri[2]==rels[1]] # 第一跳路径(精确)
    isempty(paths) && return [] # 找不到，返回无解
    for rel in rels[2:end], _ in eachindex(paths)
        path = popfirst!(paths)
        start = path[end][end]
        tris = vague_triples(start, rel, illsdata)
        append!(paths, vcat(path, [tri]) for tri in tris)
    end
    paths
end

"""获取模糊匹配"""
vague_submit(ner, rels, data) = submit_format.(
    vcat(valid_path.(find_vague_paths(ner, rels, data), Ref(data.triple_ills2raw))...))