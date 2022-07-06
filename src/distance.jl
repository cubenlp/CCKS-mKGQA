# 距离相关函数
using StringDistances

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
findbest(words::AbstractVector, target; char=true) = argmin(i -> dist(target, i; char=char), words)

"""
    nearby(words::AbstractVector, target; best=10, char=true)

在 words 中匹配与 target 最近的前 best 个结果
"""
nearby(words::AbstractVector) = Base.Fix1(nearby, words)
function nearby(words::AbstractVector, target; best=10, char=true, index=false)
    worddists = [dist(target, word; char=char) for word in words]
    n = length(words)
    inds = sort(1:n, by = i->worddists[i])[1:min(best, n)]
    filter!(i->worddists[i] != typemax(Int), inds)
    index ? inds : words[inds]
end
