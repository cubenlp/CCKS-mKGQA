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

# 读入字典
en_words = _shift.(unique!(vcat(first.(en_triples), first.(ILLs))))
zh_words = _shift.(unique!(vcat(first.(zh_triples), last.(ILLs))))
words = unique!(vcat(en_words, zh_words))

# 构建字典树
dict, dict_en, dict_zh = PrefixTree(), PrefixTree(), PrefixTree()
for word in words
    add_node!(dict, word)
end
for word in en_words
    add_node!(dict_en, word)
end
for word in zh_words
    add_node!(dict_zh, word)
end

"匹配问题中的实体"
function search_subject(que)
    # 从所有头实体以及 ILLs 中匹配
    subs = remove_subcase(search_valid_word(dict, que))
    length(subs) == 1 && return subs
    # 剩下的大部分是中文问题，带英文关键字
    # 从英文实体以及 ILLs 英文实体中匹配
    en_subs = remove_subcase(search_valid_word(dict_en, que))
    length(en_subs) == 1 && return en_subs
    # 从中文实体以及 ILLs 中文实体中匹配
    zh_subs = remove_subcase(search_valid_word(dict_zh, que))
    length(zh_subs) == 1 && return zh_subs
    subs
end

function get_subject(que)
    subs = search_subject(que)
    isempty(subs) && return ""
    argmax(length, subs)
end