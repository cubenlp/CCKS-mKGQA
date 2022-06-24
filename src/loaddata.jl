cd("../data")
# en triples
txts = strip(read(open("extract/triple_en.txt", "r"), String))
en_triples = [NTuple{3, String}(split(txt, '\t')) for txt in split(txts, '\n')]
# zh triples
txts = strip(read(open("extract/triple_zh.txt", "r"), String))
zh_triples = [NTuple{3, String}(split(txt, '\t')) for txt in split(txts, '\n')]
# ILLs doubles
txts = strip(read(open("extract/ILLs(zh-en).txt", "r"), String))
ILLs = [NTuple{2, String}(split(txt, '\t')) for txt in split(txts, '\n')]

# 格式转化
_shift(st::AbstractString) = replace(st, '_' => ' ')
# 训练集和 NER
train_ques_ner, train_sols = Tuple{String, String}[], Vector{NTuple{4, String}}[]
open("extract/train_data.txt", "r") do io
    while (que = readline(io)) != ""
        que, ner = split(que, '\t')
        push!(train_ques_ner, (que, ner))
        sols = NTuple{4, String}[]
        while (line = readline(io)) != ""
            push!(sols, Tuple(split(line, '\t')))
        end
        push!(train_sols, sols)
    end
end

# 处理验证集
valid_ques = Vector{String}(split(
        strip(read(open("extract/valid_data.txt", "r"), String)), '\n'))

# 语言模式-用于区分英文，法语
txt = "U+20-5F, U+61-7A, U+7C, U+A0, U+A7, U+A9, U+AB, U+B2-B3, U+BB, U+C0, U+C2, U+C6-CB, U+CE-CF, U+D4, U+D9, U+DB-DC, U+E0, U+E2, U+E6-EB, U+EE-EF, U+F4, U+F9, U+FB-FC, U+FF, U+152-153, U+178, U+2B3, U+2E2, U+1D48-1D49, U+2010-2011, U+2013-2014, U+2019, U+201C-201D, U+2020-2021, U+2026, U+202F-2030, U+20AC, U+2212"
code_range = [strip(t)[3:end] for t in split(txt, ',')]
french = Char[]
for code in code_range
    if '-' ∉ code
        push!(french, Char(parse(Int, "0x"*code)))
    else
        st, en = split(code, '-')
        append!(french, Char.(parse(Int, "0x"*st):parse(Int, "0x"*en)))
    end
end
french = join(french)
isfrench(c::AbstractChar) = c ∈ french
isfrench(txt::AbstractString) = all(isfrench, txt)