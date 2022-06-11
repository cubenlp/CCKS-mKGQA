# 数据预处理-Julia
paths = Dict(
    "ILLs_zh_en" => "../data/ILLs(zh-en).txt",
    "train_data" => "../data/train_data.txt",
    "triple_en" => "../data/triple_en.txt",
    "triple_zh" => "../data/triple_zh.txt"
)

output_path = "../data/extract/"

cd(Base.source_dir())
cd("../data")

en_obj_reg = r"<http://dbpedia.org/resource/(.*)>"
en_rel_reg = r"<http://dbpedia.org/property/(.*)>"
zh_obj_reg = r"<http://zh.dbpedia.org/resource/(.*)>"
zh_rel_reg = r"<http://zh.dbpedia.org/property/(.*)>"
