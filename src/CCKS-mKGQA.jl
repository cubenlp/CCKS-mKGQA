# 公用的代码部分
using DataStructures

function sort_count(list)
    c_list = counter(list)
    sort(Dict(c_list), by=i->c_list[i], rev=true)
end

function readtuples(path; size=3)
    txts = strip(read(open(path, "r"), String))
    [NTuple{size, String}(split(txt, '\t')) for txt in split(txts, '\n')]
end