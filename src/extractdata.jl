# 导入 extract 中的数据

cd("../data")
# 读取三元组
# en triples
txts = strip(read(open("extract/triple_en.txt", "r"), String))
en_triples = [NTuple{3, String}(split(txt, '\t')) for txt in split(txts, '\n')]
en_subs, en_objs = @. unique!([first(en_triples), last(en_triples)])
en_words = union(en_subs, en_objs)

# zh triples
txts = strip(read(open("extract/triple_zh.txt", "r"), String))
zh_triples = [NTuple{3, String}(split(txt, '\t')) for txt in split(txts, '\n')]
zh_subs, zh_objs = @. unique!([first(zh_triples), last(zh_triples)])
zh_words = union(zh_subs, zh_objs)
# 整合
words = union(zh_words, en_words)
triples = unique!(vcat(en_triples, zh_triples))

# ILLs doubles
txts = strip(read(open("extract/ILLs(zh-en).txt", "r"), String))
ILLs = [NTuple{2, String}(split(txt, '\t')) for txt in split(txts, '\n')]

# wiki ILLs
txts = strip(read(open("extract/wiki_ills.txt", "r"), String))
wiki_ILLs = [NTuple{2, String}(split(txt, '\t')) for txt in split(txts, '\n')]

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