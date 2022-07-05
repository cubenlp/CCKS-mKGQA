cd(Base.source_dir())
include("../src/extractdata.jl")
include("../src/scrap.jl")

en_words = unique!(vcat(first.(en_triples), last.(en_triples)))

open("ILLs/wiki_ills.txt", "w") do io
    for word in en_words
        println(word)
        zh = wiki_en2zh(word)
        isempty(zh) || println(io, word, '\t', zh)
    end
end

open("ILLs/wiki_ills.txt", "w") do io
    @sync for (i, en) in enumerate(en_words)
        @async begin
        zh = wiki_en2zh(en)
        isempty(zh) || println(io, en, '\t', zh)
        println(i, en, '\t', zh)
        end
    end
end