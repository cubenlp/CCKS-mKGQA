# 公用的代码部分
using DataStructures

"""计数并返回排序信息（调试用）"""
function sort_count(list)
    c_list = counter(list)
    sort(Dict(c_list), by=i->c_list[i], rev=true)
end

"""读取文本文件中的元组"""
function readtuples(path; size=3)
    txts = strip(read(open(path, "r"), String))
    [NTuple{size, String}(split(txt, '\t')) for txt in split(txts, '\n')]
end

"""元组拼接"""
@inline tuplejoin(x::Tuple, y::Tuple) =  (x..., y...)
@inline tuplejoin(x::Tuple, y::Tuple, z::Tuple...) = tuplejoin(tuplejoin(x, y), z...)