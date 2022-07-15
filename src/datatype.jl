# 数据结构
mutable struct ILLsData
    illsname::String
    # 原始三元组（加上语言信息为四元组）
    raw_triples::Vector
    # 三元组翻译
    mt_words::AbstractDict
    mt_rels::AbstractDict
    ILLs::Vector
    mtILLs::Vector
    triple_raw2mt::Function
    mt_triples::Vector
    # 三元组对齐
    
    equivILLs::AbstractDict
    word_mt2ills::AbstractDict
    ills_edges::AbstractDict
    triple_mt2ills::Function
    triple_raw2ills::Function
    # 三元组逆向
    ills_triples::Vector
    triple_ills2raw::AbstractDict
    
    ## 初始化
    function ILLsData(illsname::String, raw_triples::Vector, mt_words::AbstractDict, 
        mt_rels::AbstractDict, ILLs::Vector)
        # 初始化翻译
        res = new(illsname, raw_triples, mt_words, mt_rels, ILLs)
        ## 翻译对齐文件
        mtILLs = [(mt_words[i], mt_words[j]) for (i, j) in ILLs]
        res.mtILLs = filter!(i->i[1]!=i[2], unique!(mtILLs))
        ## 翻译三元组
        res.triple_raw2mt = triple_raw2mt(triple) = triple_raw2mt(triple...)
        triple_raw2mt(sign, sub, rel, obj) = (mt_words[sub], mt_rels[rel], mt_words[obj])
        res.mt_triples = mt_triples = triple_raw2mt.(raw_triples)
        # 初始化对齐
        ## 转化 ILLs 文件
        res.equivILLs = equivILLs = equivclass(mtILLs) # ettalign.jl
        res.word_mt2ills = word_mt2ills = Dict(key => val[1] for (key, val) in equivILLs)
        # 对齐函数，字典和元组
        triple_mt2ills(triple) = triple_mt2ills(triple...)
        triple_mt2ills(sub, rel, obj) = (get(word_mt2ills, sub, sub),
            rel, get(word_mt2ills, obj, obj))
        res.triple_mt2ills = triple_mt2ills
        res.ills_triples = ills_triples = triple_mt2ills.(mt_triples)
        # 对齐数据生成边集
        edges = DefaultDict{String, Vector{Tuple}}(Vector{Tuple})
        for (sub, rel, obj) in ills_triples
            push!(edges[sub], (rel, obj))
        end
        res.ills_edges = edges
        # 原始数据 => 对齐数据
        triple_raw2ills(triple...) = triple_mt2ills(triple_raw2mt(triple...))
        res.triple_raw2ills = triple_raw2ills
        res.triple_ills2raw = inversedict(triple_raw2ills, raw_triples)
        res
    end
end

Base.show(io::IO, data::ILLsData) = show(io, data.illsname)