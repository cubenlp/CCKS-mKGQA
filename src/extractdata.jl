# 导入 extract 中的数据

cd("../data")
# 读取三元组
# en triples
txts = strip(read(open("extract/triple_en.txt", "r"), String))
en_triples = [NTuple{3, String}(split(txt, '\t')) for txt in split(txts, '\n')]
# zh triples
txts = strip(read(open("extract/triple_zh.txt", "r"), String))
zh_triples = [NTuple{3, String}(split(txt, '\t')) for txt in split(txts, '\n')]
# ILLs doubles
txts = strip(read(open("extract/ILLs(zh-en).txt", "r"), String))
ILLs = [NTuple{2, String}(split(txt, '\t')) for txt in split(txts, '\n')]
ILLs_zh_en = Dict(@. last(ILLs) => first(ILLs))

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