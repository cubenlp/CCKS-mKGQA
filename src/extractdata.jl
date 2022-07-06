# 导入 extract 中的数据

cd("../data")
# 读取三元组
# en triples
en_triples = readtuples("extract/triple_en.txt")
en_subs, en_objs = @. unique!([first(en_triples), last(en_triples)])
en_words = union(en_subs, en_objs)

# zh triples
zh_triples = readtuples("extract/triple_zh.txt")
zh_subs, zh_objs = @. unique!([first(zh_triples), last(zh_triples)])
zh_words = union(zh_subs, zh_objs)
# 整合
words = union(zh_words, en_words)
wordset = Set(words)
triples = unique!(vcat(en_triples, zh_triples))

# ILLs doubles
ILLs = readtuples("extract/ILLs(zh-en).txt"; size=2)

# wiki ILLs
wiki_ILLs = readtuples("extract/wiki_ills.txt"; size=2)

# 读取训练集和 NER
train_ques_ner, train_sols = Tuple{String, String}[], Vector{NTuple{4, String}}[]
open("extract/train_data.txt", "r") do io
    while (que = readline(io)) != ""
        que, ner = split(que, '\t')
        push!(train_ques_ner, (que, ner))
        sols = NTuple{4, String}[]
        while (line = readline(io)) != ""
            push!(sols, Tuple(split(line, '\t')))
        end
        push!(train_sols, sols)
    end
end

# 读取验证集
valid_ques = Vector{String}(split(
        strip(read(open("extract/valid_data.txt", "r"), String)), '\n'))

valid_ques_ner = split.(Vector{String}(split(
        strip(read(open("extract/valid_data_ner.txt", "r"), String)), '\n')), '\t')