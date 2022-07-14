# 导入对齐数据 - 依赖变量 illpath
cd("../data/")

# 确保执行前已导入翻译数据
# include("../src/translate.jl")
# include("../src/extractdata.jl")

# 原始对齐
newILLs = readtuples("EA_data/$illpath/ETT_Pairs.txt"; size=2);
filter!(i->i[1] ∈ wordset && i[2] ∈ wordset, newILLs);

# 翻译对齐
mt_newILLs = [getindex.(Ref(dict_mtwords), pair) for pair in newILLs]
filter!(i->i[1]!=i[2], unique!(mt_newILLs)) # 首尾不相等
println("对齐数目-翻译后的数目：\t", length.([newILLs, mt_newILLs])) # 13055 => 9802

# 实体对齐表
equivills = equivclass(mt_newILLs)
# 实体对齐的字典映射
dict_ILLs = Dict(key=>val[1] for (key, val) in equivills)

# 三元组
triple_mt2ills(triple) = triple_mt2ills(triple...)
triple_mt2ills(sub, rel, obj) = (get(dict_ILLs, sub, sub), rel, get(dict_ILLs, obj, obj))
triple_raw2ills(triple...) = triple_mt2ills(triple_raw2mt(triple...))
ill_triples = unique!(triple_mt2ills.(mt_triples))

# 验证集
ill_valid_ners = [get(dict_ILLs, ner, ner) for ner in last.(mt_valid_ques_ner)]
ill_valid_ques = first.(mt_valid_ques_ner)

# 训练集
ill_train_ners = [get(dict_ILLs, ner, ner) for ner in getindex.(mt_train_ques_rels, 2)]
ill_train_ques = mt_train_ques
ill_train_sols = [triple_raw2ills.(getindex.(sols, Ref(2:4))) for sols in train_sols]
ill_train_rels = [getindex.(sols, 2) for sols in ill_train_sols]


# 构建边集
edges = DefaultDict{String, Vector{Tuple}}(Vector{Tuple})
for (sub, rel, obj) in ill_triples
    push!(edges[sub], (rel, obj))
end

# 反转字典
f(raw) = String.(triple_raw2ills(raw[2:end]))
dict_triples_rev = inversedict(f, raw_triples)