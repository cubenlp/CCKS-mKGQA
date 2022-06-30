# 关系抽取与实体对齐
using StringDistances
using DataStructures

"字典排序"
function sort_count(list)
    c_list = counter(list)
    sort(Dict(c_list), by=i->c_list[i], rev=true)
end
# 索引工具
take(ind::Int) = list->list[ind]

"""
    dist(target, word; char=true)

计算 target 和 word 的距离:
 - 默认匹配字符距离，适用于问题匹配
 - 指定 `char=false` 将单词作为整体匹配，适用于实体匹配
"""
function dist(target, word; char=true)
    # char 指定是否用字符匹配
    char || (target = split(target, '_'); word = split(word, '_'))
    all(∉(Set(target)), word) && return typemax(Int)
    # 计算距离
    evaluate(Levenshtein(), target, word)
    # evaluate(DamerauLevenshtein(), target, word)
end


"计算字串的 Levenshtein 距离"
nearby(words::AbstractVector) = Base.Fix1(nearby, words)
function nearby(words::AbstractVector, target; best=10, char=true)
    worddists = [dist(target, word; char=char) for word in words]
    n = length(words)
    inds = sort(1:n, by= i->worddists[i])[1:min(best, n)]
    words[inds], worddists[inds]
end

