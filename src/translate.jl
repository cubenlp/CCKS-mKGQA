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

english = join(join.(['a':'z', 'A':'Z', '0':'9', "_ -()"]))
isenglish(c::AbstractChar) = c ∈ english
isenglish(txt::AbstractString) = all(isenglish, txt)


# 关系中的少量规则修改
rel_rules = (
    "mittelstädte" => "medium-sized_towns",
    "écoulement" => "flow",
    "résidenceOfficielle" => "official_residence",
    "siège" => "headquarters",
    r"\d上一節目" => "上一節目",
    r"\d+下一節目" => "下一節目",
    "é" => "e");


"问句首字母小写"
lowerque(st) = replace(st, 
    "What "=>"what ", 
    "Which "=>"which ", 
    "Where " => "where ",
    "Do " => "do ",
    "In which " => "in which ",
    "Who " => "who ",
    "How " => "how "
)

_2space(st::AbstractString) = replace(st, '_' => ' ')

"""用 Excel 文件与谷歌翻译交互"""
function MT_questions(ques, filename; write=true)
    filename = split(filename, '.')[1]
    french_ques = filter(isfrench, ques)
    chinese_ques = filter(!isfrench, ques)
    if write # 写入文件
        write_xlsx(filename * "_fr.xlsx", french_ques)
        write_xlsx(filename * "_zh.xlsx", chinese_ques)
    else # 读入文件
        MT_fr_ques = lowerque.(strip.(read_xlsx("$(filename)_fr_MT.xlsx")))
        MT_zh_ques = lowerque.(strip.(read_xlsx("$(filename)_zh_MT.xlsx")))
        MT_fr = Dict((=>).(french_ques, MT_fr_ques))
        MT_zh = Dict((=>).(chinese_ques, MT_zh_ques))
        MT_que(que) = haskey(MT_fr, que) ? MT_fr[que] : MT_zh[que]
        MT_que.(ques)
    end
end