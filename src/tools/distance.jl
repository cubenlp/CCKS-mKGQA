# 距离相关函数
using StringDistances

"""
    dist(target::AbstractString, word::AbstractString)

返回单词串 target 和 word 的距离:
"""
function dist(target::AbstractString, word::AbstractString)
     # 单词作为整体
    target = split(target, '_');word = split(word, '_')
    all(∉(Set(target)), word) && return typemax(Int) # 没有交集，返回无穷大
    evaluate(Levenshtein(), target, word) # 计算距离
end

"""
    dist(targets::AbstractVector, words::AbstractVector)

返回字串集合 target 和 word 的距离
"""
function dist(targets::AbstractVector, words::AbstractVector)
    minimum(dist(target, word) for target in targets for word in words)
end

"""
    chardist(target::AbstractString, word::AbstractString)

返回字串 target 和 word 的距离:
"""
function chardist(target::AbstractString, word::AbstractString)
    all(∉(Set(target)), word) && return 10000 # 没有交集，返回超大数值
    evaluate(Levenshtein(), target, word) # 计算距离
end