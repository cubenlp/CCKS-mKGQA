# 正则语法，匹配实体关系
en_obj_reg = r"<http://dbpedia.org/resource/(.*)>"
en_rel_reg = r"<http://dbpedia.org/property/(.*)>"
zh_obj_reg = r"<http://zh.dbpedia.org/resource/(.*)>"
zh_rel_reg = r"<http://zh.dbpedia.org/property/(.*)>"

"从 txt 中匹配 reg"
function get_txt(reg, txt)
    mat = match(reg, txt)
    isnothing(mat) && return ""
    mat.captures[1]
end

"从单行提取三元组"
function line2triple(line; en=true)
    txts = split(line, ' ')
    rel, obj = en ? (en_rel_reg, en_obj_reg) : (zh_rel_reg, zh_obj_reg)
    Tuple(get_txt.([obj, rel, obj], txts))
end

# 处理问题错位
lg, rg, substr = "([A-Z0-9])", raw"([\w ,'()/–\-\.]+)", s"\g<1>\g<2>"
ill_reg(rep) = Regex(lg * rep * rg) => SubstitutionString(substr * rep)
ill_pattern = ill_reg.([
        "'s name", # 211
        "'s southern region", # 190
        " known", # 166
        "'s famous works", # 140
        "-related products", # 101
        "'s related products", # 63
        "[ -]related events", # 35
        "-related event related persons",
        "'s season",
        " related data",
        "'s head coach",
        "'s data source",
        " related event"
]);
push!(ill_pattern,
    r"([^A-Za-z0-9])-held parliament([^A-Za-z0-9]+)(?<![ ?])" => s"\g<1>\g<2>-held parliament", # 21
    r"which ([^A-Za-z0-9]) belongs([^A-Za-z0-9]+)(?<![ ?])" => s"\g<1>\g<2> belongs", # 16
)
rectify_que(que::AbstractString) = replace(que, ill_pattern...)