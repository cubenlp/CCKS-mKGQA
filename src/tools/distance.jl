# 距离相关函数
using StringDistances

"""
    dist(target::AbstractString, word::AbstractString)

返回字串 target 和 word 的距离:
"""
function dist(target::AbstractString, word::AbstractString)
     # 单词作为整体
    target, word = split(target, '_'), split(word, '_')
    all(∉(Set(target)), word) && return typemax(Int) # 没有交集，返回无穷大
    evaluate(Levenshtein(), target, word) # 计算距离
end

"""
    dist(targets::AbstractVector, words::AbstractVector; char=false)

返回字串集合 target 和 word 的距离
"""
function dist(targets::AbstractVector, words::AbstractVector; char=false)
    minimum(dist(target, word) for target in targets for word in words)
end