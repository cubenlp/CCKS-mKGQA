# 读取文件：中英文知识图谱头实体，关系，尾实体；对齐文件
cd("../data")
function readtriples(filename::AbstractString)
    txts = rstrip(read(open(filename, "r"), String))
    [NTuple{3, String}(split(txt, '\t')) for txt in split(txts, '\n')]
end
# 中文头实体
zh_triples = readtriples("extract/triple_zh.txt")
zh_subs = unique!(first.(zh_triples))
zh_objs = unique!(last.(zh_triples))
zh_entity = unique!(vcat(zh_subs, zh_objs))
zh_rels = unique(triple[2] for triple in zh_triples)

# 英文头实体
en_triples = readtriples("extract/triple_en.txt")
en_subs = unique!(first.(en_triples))
en_objs = unique!(last.(en_triples))
en_entity = unique!(vcat(en_subs, en_objs))
en_rels = unique(triple[2] for triple in en_triples)


# ILLs 对齐文件
txts = rstrip(read(open("extract/ILLs(zh-en).txt", "r"), String))
ILLs = Dict{String,String}(split(txt, '\t') for txt in split(txts,'\n'))
ILLs_zh_en = Dict{String,String}(b=>a for (a,b) in ILLs)

# 训练集
train_data = Dict{String, Vector{NTuple{4, String}}}()
open("extract/train_data.txt", "r") do io
    for _ in 1:14077
        que = readline(io)
        ind, que = parse(Int, que[2]), que[5:end]
        train_data[que] = [Tuple(split(readline(io), '\t')) for _ in 1:ind]
        readline(io)
    end
end

# 读入翻译后的
en_triples_1 = readtriples("translate/triple_en_1.txt")
en_triples_2 = readtriples("translate/triple_en_2.txt")

# 读入翻译前的数据
raw_en_triples = readtriples("raw_triple/triple_en.txt")
raw_zh_triples = readtriples("raw_triple/triple_zh.txt")

MT_en = Dict((=>).(raw_en_triples, en_triples_1))
MT_zh = Dict((=>).(raw_zh_triples, en_triples_2))
MT_en_rev = Dict((=>).(en_triples_1, raw_en_triples))
MT_zh_rev = Dict((=>).(en_triples_2, raw_zh_triples))

french = " !\"#\$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_abcdefghijklmnopqrstuvwxyz| §©«²³»ÀÂÆÇÈÉÊËÎÏÔÙÛÜàâæçèéêëîïôùûüÿŒœŸʳˢᵈᵉ‐‑–—’“”†‡… ‰€−"
isfrench(c::AbstractChar) = c ∈ french
isfrench(txt::AbstractString) = all(isfrench, txt)

println("导入成功，内容概要：
    | 变量名 | 说明 |
    | ---- | ---- |
    | zh_triples/en_triples | 三元组 |
    | zh_subs/en_subs | 头实体 |
    | zh_objs/en_objs | 尾实体 |
    | zh_rels/en_rels | 关系 |
    | zh_entity/en_entity | 实体（头和尾） |
    | ILLs | 英文 => 中文对齐 |
    | ILLs_zh_en | 中文 => 英文对齐|
    | train_data | 训练集 |
    | MT_en/zh(_rev) | 三元组翻译 |")