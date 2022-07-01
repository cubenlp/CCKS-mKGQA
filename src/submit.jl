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
function submit(sol)
    # 提取信息
    sol = split(sol, '\t')
    que, ner, rels = sol[1], sol[2], sol[3:end]
    # 获取问题解答
    paths = filter(i->length(unique(i[1]))>1, find_paths(ner, rels))
    if !isempty(paths)
        sign, path = last(paths)
    else
        rels = find_rels(que)
        sign, path = find_paths_vague(ner, rels)
    end 
    submit_format(path, sign)
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


### 以下为路径推理 ### 



# 初始化查询字典
train_rels = DefaultDict{String, Vector{Tuple}}(Vector{Tuple})
for sols in unique(train_ques_sols)
    que = first(sols)
    rels = Tuple(@view(sols[3:end]))
    rels ∉ train_rels[que] && push!(train_rels[que], rels)
end
"匹配最近 10 个问题"
top10 = nearby(unique(train_ques))

function find_rels(que)
    ques, scores = top10(que)
    rels = vcat([train_rels[que] for que in ques]...)
    rel1 = first(sort_count(counter(first.(rels))))[1]
    rel2 = first(sort_count(counter(take(2).(rels))))[1]
    return [rel1, rel2]
end


"寻找子图，但推理对齐"
function find_paths_vague(ner, rels)
    tri1 = filter(i->i[1]==ner && i[2]==rels[1], triples)[1]
    possible = filter(i->i[2] == rels[2], triples)
    res, scores = nearby(first.(possible), tri1[3]; char=false)
    tri2 = filter(i->i[1]==res[1] && i[2]==rels[2], triples)[1]
    if length(rels) == 2
        standard_path([tri1, tri2])[1]
    else
        possible = filter(i->i[2] == rels[3], triples)
        res, scores = nearby(first.(possible), tri2[3]; char=false)
        tri3 = filter(i->i[1]==res[1] && i[2]==rels[3], triples)[1]
        standard_path([tri1, tri2, tri3])[1]
    end
end