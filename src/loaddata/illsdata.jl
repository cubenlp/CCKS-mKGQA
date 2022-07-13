# 导入对齐数据 - 依赖变量 illpath
cd("../data/")

newILLs = readtuples("EA_data/$illpath/ETT_Pairs.txt"; size=2);
filter!(i->i[1] ∈ wordset && i[2] ∈ wordset, newILLs);