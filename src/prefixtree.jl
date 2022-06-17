"前缀树"
Base.@kwdef mutable struct PrefixTree
    isend::Bool = false
    children = Dict{Char,PrefixTree}()
end

"给前缀树增加单词"
function add_node!(node::PrefixTree, word::String)::Nothing
    for c in word
        children = node.children
        haskey(children, c) || (children[c] = PrefixTree())
        node = children[c]
    end
    node.isend = true
    return nothing
end

"在字符串里匹配字典单词"
function search_valid_word(node::PrefixTree, word::String)
    res, n, word = String[], length(word), collect(word)
    for i in 1:n
        # 检索 word[i:end]
        dict = node
        for j in i:n
            haskey(dict.children, word[j]) || break # 不存在到该位置的路径
            dict = dict.children[word[j]] # 切换到该节点
            dict.isend && push!(res, join(word[i:j]))
        end
    end
    res
end

"删除子串"
function remove_subcase(subs)
    # (n = length(subs)) == 1 && return subs
    sort!(subs, by=length)
    res, n = String[], length(subs)
    for (i, sub) in enumerate(subs)
        any(j->occursin(sub, subs[j]), (i+1):n) || push!(res, sub)
    end
    res
end