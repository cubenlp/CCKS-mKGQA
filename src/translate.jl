cd("../data")
# 处理后的图谱
en_triples_1 = readtriples("extract/triple_en.txt")
en_triples_2 = readtriples("translate/triple_en_byzh.txt")

# 原始图谱
raw_en_triples = readtriples("raw_triple/triple_en.txt")
raw_zh_triples = readtriples("raw_triple/triple_zh.txt")

# 建立翻译关系
MT_en_raw2new = Dict((=>).(raw_en_triples, en_triples_1))
MT_zh_raw2new = Dict((=>).(raw_zh_triples, en_triples_2))
MT_en_rev = Dict((=>).(en_triples_1, raw_en_triples))
MT_zh_rev = Dict((=>).(en_triples_2, raw_zh_triples))