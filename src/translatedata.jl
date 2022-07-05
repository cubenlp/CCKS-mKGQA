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

# 三元组关系
txts = split.(split(strip(read(open("translate/rels_zh2en.txt", "r"), String)), '\n'), '\t')
dict_rels = Dict(zh=>en for (zh, en) in txts)

# 读取 ILLs
# 官方 ILLs 文件
txts = split(strip(read(open("translate/ILLs(zh-en).txt", "r"), String)), '\n')
ILLs = Tuple.(split.(txts, '\t'))
# 维基 ILLs 文件
txts = split(strip(read(open("translate/wiki_ills.txt", "r"), String)), '\n')
wiki_ILLs = Tuple.(split.(txts, '\t'))

# 读取三元组
function readtriples(path)
    txts = strip(read(open(path, "r"), String))
    [NTuple{3, String}(split(txt, '\t')) for txt in split(txts, '\n')]
end
# 翻译后的图谱
triples = readtriples("translate/triples.txt")
en_triples = readtriples("translate/en_triples.txt")
zh_triples = readtriples("translate/zh_triples.txt")
# 原始图谱
raw_en_triples = readtriples("raw_data/raw_triple/triple_en.txt")
raw_zh_triples = readtriples("raw_data/raw_triple/triple_zh.txt")

dict_entriples_new2raw = Dict((=>).(en_triples, raw_en_triples))
dict_zhtriples_new2raw = Dict((=>).(zh_triples, raw_zh_triples))
