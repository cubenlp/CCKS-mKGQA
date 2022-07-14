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
dict_mtrels = Dict(zh=>en for (zh, en) in txts)

## 翻译实体
txts = split.(split(strip(read(open("translate/words_raw2new.txt", "r"), String)), '\n'), '\t')
dict_mtwords = Dict(zh=>en for (zh, en) in txts)

## 翻译三元组
triple_raw2mt(triple) = triple_raw2mt(triple...)
triple_raw2mt(sub, rel, obj) = (dict_mtwords[sub], dict_mtrels[rel], dict_mtwords[obj])
mt_triples = readtuples("translate/triples.txt")
