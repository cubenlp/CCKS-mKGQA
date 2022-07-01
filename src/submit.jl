# 路径搜索与标准格式生成
using DataStructures

# 三元组还原
en_standard = Dict((=>).(en_triples_lower, raw_en_triples))
zh_standard = Dict((=>).(zh_triples_lower, raw_zh_triples))

"三元组 => 提交形式"
function triple2link(triple, lang)
    sub, rel, obj = triple
    if lang == 'e'
        "<http://dbpedia.org/resource/$sub>#" * 
        "<http://dbpedia.org/property/$rel>#" *
        "<http://dbpedia.org/resource/$obj>"
    elseif lang == 'z'
        "<http://zh.dbpedia.org/resource/$sub>#" * 
        "<http://zh.dbpedia.org/property/$rel>#" *
        "<http://zh.dbpedia.org/resource/$obj>"
    end
end

# 初始化边集
edges = DefaultDict{String, Vector{Tuple}}(Vector{Tuple})
for (sub, rel, obj) in triples
    push!(edges[sub], (rel, obj))
end

"寻找从 ner 出发以 rels 为关系的子图（不做路径推理）"
function find_paths(ner, rels)
    paths = [[(ner, "", ner)]] # 初始路径
    for rel in rels, _ in eachindex(paths)
        path = popfirst!(paths) 
        ner = path[end][end] # 取路径终点
        for (newrel, obj) in edges[ner]
            newrel == rel && push!(paths, vcat(path, (ner, newrel, obj)))
        end
    end
    popfirst!.(paths) # 去除路径的初始节点（平凡）
    paths
end

"翻译的三元组路径 => 原始三元组路径 + 三元组语言信息"
function valid_path(path)
    signs = [""]
    # BFS 搜索可能的符号信息
    for triple in path, _ in eachindex(signs)
        s = popfirst!(signs) # 当前符号路径
        haskey(zh_standard, triple) && push!(signs, s * "z")
        haskey(en_standard, triple) && push!(signs, s * "e")
    end
    [[sign, [s == 'z' ? zh_standard[t] : en_standard[t] 
            for (s,t) in zip(sign, path)]] for sign in signs if length(unique(sign)) > 1]
end

"三元组路径 => 提交形式"
submit_format(triples, langs) = join([triple2link(triple, lang)
        for (triple, lang) in zip(triples, langs)], '#')

"提取有效的解答"
valid_submit(sol::AbstractString) = valid_submit(split(sol, '\t'))
function valid_submit(sol::AbstractVector)
    que, ner, rels = sol[1], sol[2], sol[3:end]
    paths = find_paths(ner, rels)
    valids = String[]
    for path in paths, (sign, tris) in valid_path(path)
        push!(valids, submit_format(tris, sign))
    end
    valids
end