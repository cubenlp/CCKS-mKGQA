using HTTP
using Gumbo
using AbstractTrees

# 中文翻译
zhpage(word) = HTTP.get("https://zh.wikipedia.org/wiki/$word")
wiki_zh2en(page) = wiki_keyword(page, "en" => " – 英语")
wiki_zh2en(word::AbstractString) = wiki_zh2en(zhpage(word))

# 英文翻译
enpage(word) = HTTP.get("https://en.wikipedia.org/wiki/$word")
wiki_en2zh(page) = wiki_keyword(page, "zh" => " – Chinese")
wiki_en2zh(word::AbstractString) = wiki_en2zh(enpage(word))

"提取页面关键词"
function wiki_keyword(page, pair::Pair)
    body = parsehtml(String(page.body)).root[2] # body 标签页
    nav = get_tag(body, :nav, "id" => "p-lang") # 导航页
    langs = get_tag(nav, :ul, "class" => "vector-menu-content-list")
    # 提取英文
    for lang in langs.children
        if lang.attributes["class"] == "interlanguage-link interwiki-$(pair[1]) mw-list-item"
            en = lang.children[1].attributes["title"]
            return replace(en, "$(pair[2])" => "", ' ' => '_')
        end
    end
    ""
end

"检索标签"
function get_tag(body, symbol::Symbol, pair::Pair)
    for ele in PreOrderDFS(body)
        try
            tag(ele) == symbol && ele.attributes[pair[1]] == pair[2] && return ele
        catch
        end
    end
end
