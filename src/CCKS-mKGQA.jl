using DataStructures

function sort_count(list)
    c_list = counter(list)
    sort(Dict(c_list), by=i->c_list[i], rev=true)
end