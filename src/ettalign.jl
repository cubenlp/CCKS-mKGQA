using DataStructures

"""从 ILLs 二元组提取字典"""
function ill2dict(ILLs)
    traversed = DefaultDict{String, Vector{String}}(Vector{String})
    for (en, zh) in ILLs
        if haskey(traversed, en) # 已经出现
            if !haskey(traversed, zh) # 新的值
                push!(traversed[en], zh)
                traversed[zh] = traversed[en]
            else # 旧的值
                new = union(traversed[zh], traversed[en])
                traversed[zh] = traversed[en] = new
            end
        else
            if haskey(traversed, zh)
                push!(traversed[zh], en)
                traversed[en] = traversed[zh]
            else
                traversed[zh] = traversed[en] = [zh, en]
            end
        end
    end
    Dict(key=>val[1] for (key, val) in traversed)
end