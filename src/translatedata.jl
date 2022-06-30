cd("../data")

# 读取翻译后的数据
# 验证集
txts = split(strip(read(open("translate/valid_ques.txt", "r"), String)), '\n')
valid_ques_ner = [split(txt, '\t') for txt in txts]
valid_ques = String.(first.(valid_ques_ner))

# 训练集
txts = split(strip(read(open("translate/train_ques.txt", "r"), String)), '\n')
train_ques_sols = [split(txt, '\t') for txt in txts]
train_ques = String.(first.(train_ques_sols))

# 三元组
function readtriples(path)
    txts = strip(read(open(path, "r"), String))
    [NTuple{3, String}(split(txt, '\t')) for txt in split(txts, '\n')]
end
triples = readtriples("translate/triples.txt")

# 处理翻译后的图谱
en_triples_lower = readtriples("translate/triple_en_lower.txt")
zh_triples_lower = readtriples("translate/triple_zh_lower.txt")

# 原始图谱
raw_en_triples = readtriples("raw_triple/triple_en.txt")
raw_zh_triples = readtriples("raw_triple/triple_zh.txt")

# 建立翻译关系
MT_en_raw2new = Dict((=>).(raw_en_triples, en_triples_lower))
MT_zh_raw2new = Dict((=>).(raw_zh_triples, zh_triples_lower))
MT_en_new2raw = Dict((=>).(en_triples_lower, raw_en_triples))
MT_zh_new2raw = Dict((=>).(zh_triples_lower, raw_zh_triples))

ner_raw2new = Dict((=>).(first.(vcat(raw_en_triples, raw_zh_triples)),
        first.(vcat(en_triples_lower, zh_triples_lower))))

ner_new2raw = Dict((=>).(first.(vcat(raw_en_triples, raw_zh_triples)),
        first.(vcat(en_triples_lower, zh_triples_lower))))
