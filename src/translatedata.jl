cd("../data")

# 翻译问题
# 验证集
txts = split(strip(read(open("translate/valid_ques.txt", "r"), String)), '\n')
mt_valid_ques_ner = [split(txt, '\t') for txt in txts]
mt_valid_ques = String.(first.(mt_valid_ques_ner))

# 训练集
txts = split(strip(read(open("translate/train_ques.txt", "r"), String)), '\n')
mt_train_ques_rels = [split(txt, '\t') for txt in txts]
mt_train_ques = String.(first.(mt_train_ques_rels))

# 三元组
## 翻译关系
txts = split.(split(strip(read(open("translate/rels_raw2new.txt", "r"), String)), '\n'), '\t')
dict_rels = Dict(zh=>en for (zh, en) in txts)

## 翻译实体
txts = split.(split(strip(read(open("translate/words_raw2new.txt", "r"), String)), '\n'), '\t')
dict_words = Dict(zh=>en for (zh, en) in txts)

## 翻译三元组
triple_byMT(triple) = triple_byMT(triple...)
triple_byMT(sub, rel, obj) = (dict_words[sub], dict_rels[rel], dict_words[obj])

# # 读取三元组
# function readtriples(path)
#     txts = strip(read(open(path, "r"), String))
#     [NTuple{3, String}(split(txt, '\t')) for txt in split(txts, '\n')]
# end
# # 翻译后的图谱
# triples = readtriples("translate/triples.txt")
# # en_triples = readtriples("translate/triples/en_triples.txt")
# # zh_triples = readtriples("translate/triples/zh_triples.txt")
# # 原始图谱
# raw_en_triples = readtriples("extract/triple_en.txt")
# raw_zh_triples = readtriples("extract/triple_zh.txt")

# # dict_entriples_new2raw = Dict((=>).(en_triples, raw_en_triples))
# # dict_zhtriples_new2raw = Dict((=>).(zh_triples, raw_zh_triples))
