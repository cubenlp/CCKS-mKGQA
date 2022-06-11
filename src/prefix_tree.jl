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

### 测试案例 ###
words = ["伊格尔·茨维塔诺维奇", "克罗地亚", "伊万·哈谢克", "伊莎貝拉_(帕爾馬郡主)", "克里斯·麦克尼尔利", "克罗地亚王国", "克罗泽群岛", "伊格内修斯·库图·阿昌庞"];
dict_zh = PrefixTree()
for word in words
    add_node!(dict_zh, word)
end

question = "克罗地亚足球运动员伊格尔·茨维塔诺维奇的出生国家西南边的地方叫什么"
search_valid_word(dict_zh, question)

# function search_valid_word(node::PrefixTree, word::String)
#     res, n = String[], length(word)
#     for i in 1:n
#         # 检索 word[i:end]
#         dict = node
#         for j in i:n
#             haskey(dict.children, word[nextind(word, j-1)]) || break # 不存在到该位置的路径
#             dict = dict.children[word[nextind(word, j-1)]] # 切换到该节点
#             dict.isend && push!(res, word[nextind(word, i-1):nextind(word, j-1)])
#         end
#     end
#     res
# end