
"""从 ILLs 二元组提取字典"""
function ill2dict(ILLs::AbstractVector{Tuple{T, T}}) where T <: AbstractString
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

function triple2dict(f::Function, raw_triples::AbstractVector)
    elt1, elt2 = eltype(raw_triples), typeof(f(raw_triples[1]))
    dict = DefaultDict{elt2, Vector{elt1}}(Vector{elt1})
    for triple in raw_triples
        push!(dict[f(triple)], triple)
    end
    dict
end