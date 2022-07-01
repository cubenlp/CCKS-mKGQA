# 关系抽取与实体对齐
using StringDistances
using DataStructures


"""
    dist(target, word; char=true)

计算 target 和 word 的距离:
 - char 指定匹配方式，字符匹配适用于问题，单词匹配适用于实体
"""
function dist(target, word; char=true)
    char || (target = split(target, '_'); word = split(word, '_'))
    all(∉(Set(target)), word) && return typemax(Int)
    evaluate(Levenshtein(), target, word)
end


"""
    nearby(words::AbstractVector, target; best=10, char)

在 words 中匹配与 target 最近的前 best 个结果
"""
nearby(words::AbstractVector) = Base.Fix1(nearby, words)
function nearby(words::AbstractVector, target; best=10, char=true)
    worddists = [dist(target, word; char=char) for word in words]
    n = length(words)
    inds = sort(1:n, by= i->worddists[i])[1:min(best, n)]
    words[inds], worddists[inds]
end
findbest(words::AbstractVector, target; char=true) = argmin(i -> dist(target, i; char=char), words)


"寻找子图，不存在的情况推理实体对齐"
function find_vague_path(ner, rels)
    length(rels) == 1 && throw("只匹配到一跳")
    # 第一个三元组精确匹配
    tri1 = filter(i->i[1]==ner && i[2]==rels[1], triples)
    isempty(tri1) && throw("第一跳匹配错误")
    tri1 = tri1[1]
    
    # 第二个三元组可能的头实体
    possible = first.(filter(i->i[2] == rels[2], triples))
    # 取最匹配的情况
    sub = findbest(possible, tri1[3]; char=false)
    tri2 = filter(i->i[1]==sub && i[2]==rels[2], triples)[1]
    if length(rels) == 2
        [tri1, tri2]
    else
        possible = first.(filter(i->i[2] == rels[3], triples))
        sub = findbest(possible, tri2[3]; char=false)
        tri3 = filter(i->i[1]==sub && i[2]==rels[3], triples)[1]
        [tri1, tri2, tri3]
    end
end

vague_submit(sol::AbstractString) = vague_submit(split(sol, '\t'))
function vague_submit(sol::AbstractVector)
    que, ner, rels = sol[1], sol[2], sol[3:end]
    path = find_vague_path(ner, rels)
    # println.(path) # 调试：打印路径
    [submit_format(tris, sign) for (sign, tris) in valid_path(path)]
end



# 初始化查询字典
train_rels = DefaultDict{String, Vector{Tuple}}(Vector{Tuple})
for sols in unique(train_ques_sols)
    que = first(sols)
    rels = Tuple(@view(sols[3:end]))
    rels ∉ train_rels[que] && push!(train_rels[que], rels)
end
"匹配最近 10 个问题"
templates = unique(train_ques)
top10 = nearby(templates)
bestrel(que, ner) = train_rels[findbest(templates, que)][1]



"字典排序"
function sort_count(list)
    c_list = counter(list)
    sort(Dict(c_list), by=i->c_list[i], rev=true)
end
# 索引工具
take(ind::Int) = list->list[ind]

