# 路径搜索与数据提交格式

using DataStructures

# 初始化
edges = DefaultDict{String, Vector{Tuple}}(Vector{Tuple})
for (sub, rel, obj) in triples
    push!(edges[sub], (rel, obj))
end
en_S, zh_S = Set(en_triples_lower), Set(zh_triples_lower)
triple_lang(triple) = (triple ∈ en_S, triple ∈ zh_S)

# 基本函数
"问题-ner-若干关系 => 标准形式"
function submit(sol; check = false)
    # 提取信息
    sol = split(sol, '\t')
    que, ner, rels = sol[1], sol[2], sol[3:end]
    # ind = findfirst(==([que, ner]), valid_ques_ner) - 1
    # 获取问题解答
    paths = find_paths(ner, rels)
    check && (paths = filter(i->length(unique(i[1]))>1, paths))
    [submit_format(triples, sign) for (sign, triples) in paths]
end

"寻找子图，并返回相关的三元组"
function find_paths(ner, rels)
    paths = [[(ner, "", ner)]] # 初始只有一条路径
    # 2 <= length(rels) <= 3 || return []
    for rel in rels, _ in eachindex(paths)
        path = popfirst!(paths) 
        ner = path[end][end] # 取路径终点
        haskey(edges, ner) || continue
        for (newrel, obj) in edges[ner]
            newrel == rel && push!(paths, vcat(path, (ner, newrel, obj)))
        end
    end
    popfirst!.(paths)
    vcat(standard_path.(paths)...)
end

"还原跨语言信息"
function standard_path(path)
    signs = [""]
    for triple in path, _ in eachindex(signs)
        s = popfirst!(signs)
        triple ∈ zh_S && push!(signs, s * "z")
        triple ∈ en_S && push!(signs, s * "e")
    end
    [[sign, [s == 'z' ? MT_zh_new2raw[t] : MT_en_new2raw[t] 
            for (s,t) in zip(sign, path)]] for sign in signs]
end

"将三元组转为提交的标准形式"
function standard_triple(triple, lang)
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
"将若干三元组转为提交形式"
submit_format(triples, langs) = join([standard_triple(triple, lang)
        for (triple, lang) in zip(triples, langs)], '#')