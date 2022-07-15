# 导入对齐数据 - 依赖变量 illpath
cd("../data/")

# 确保执行前已导入翻译数据
# include("../src/loaddata/translatedata.jl")
# include("../src/loaddata/extractdata.jl")

# 原始对齐
newILLs = readtuples("EA_data/$illpath/ETT_Pairs.txt"; size=2);
filter!(i->i[1] ∈ wordset && i[2] ∈ wordset, newILLs);
# 转化后的对齐数据
illsdata = ILLsData(illpath, raw_triples, dict_mtwords, dict_mtrels, newILLs)
word_mt2ills = illsdata.word_mt2ills
triple_raw2ills = illsdata.triple_raw2ills

# 验证集
ill_valid_ners = [get(word_mt2ills, ner, ner) for ner in last.(mt_valid_ques_ner)]
ill_valid_ques = first.(mt_valid_ques_ner)

# 训练集
ill_train_ners = [get(word_mt2ills, ner, ner) for ner in getindex.(mt_train_ques_rels, 2)]
ill_train_ques = mt_train_ques
ill_train_sols = [triple_raw2ills.(sols) for sols in train_sols]
ill_train_rels = [getindex.(sols, 2) for sols in ill_train_sols]
