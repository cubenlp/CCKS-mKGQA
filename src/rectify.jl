# 正则规则 7 + 2
lg, rg, substr = "([A-Z])", raw"([\w ,'()/–\-\.]+)", s"\g<1>\g<2>"
ill_rules(rep) = Regex(lg * rep * rg) => SubstitutionString(substr * rep)
ill_pattern = ill_rules.([
        "'s name", # 211
        "'s southern region", # 190
        " known", # 166
        "'s famous works", # 140
        "-related products", # 101
        "'s related products", # 63
        " related events", # 35
])
push!(ill_pattern,
    r"([^A-Za-z0-9])-held parliament([^A-Za-z0-9]+)(?<![ ?])" => s"\g<1>\g<2>-held parliament", # 21
    r"which ([^A-Za-z0-9]) belongs([^A-Za-z0-9]+)(?<![ ?])" => s"\g<1>\g<2> belongs", # 16
)

rectify_que(que::AbstractString) = replace(que, ill_pattern...)