
"""二元等价关系 => 等价类"""
function equivclass(pairs::AbstractVector{Tuple{T, T}}) where T
    equivdict = DefaultDict{T, Vector{T}}(Vector{T})
    for (left, right) in pairs
        # 左右均未遍历
        if !haskey(equivdict, left) && !haskey(equivdict, right)
            equivdict[left] = equivdict[right] = [left, right]
            continue
        end
        # 不妨设左值已遍历
        haskey(equivdict, right) && ((left, right) = (right, left))
        if !haskey(equivdict, right) # 右值未遍历，加入左值所在等价类
            push!(equivdict[left], right)
            equivdict[right] = equivdict[left]
        else # 右值已遍历，合并等价类
            new = union(equivdict[left], equivdict[right])
            equivdict[left] = equivdict[right] = new
        end
    end
    equivdict         
end


"""返回逆映射字典"""
function inversedict(f::Function, preimgs::AbstractVector)
    elt1, elt2 = eltype(preimgs), typeof(f(preimgs[1]))
    dict = DefaultDict{elt2, Vector{elt1}}(Vector{elt1})
    for preimg in preimgs
        push!(dict[f(preimg)], preimg)
    end
    dict
end