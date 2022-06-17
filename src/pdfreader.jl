using PDFIO
# doc = pdDocOpen("/home/rex/download/zh_rels.pdf")
# docinfo = pdDocGetInfo(doc)
# pdDocGetPageCount(doc) # 页数
# page = pdDocGetPage(doc, 1)
# pdPageExtractText(stdout, page)
# pdDocClose(doc)
function getPDFText(src, out)
    # handle that can be used for subsequence operations on the document.
    doc = pdDocOpen(src)
    
    # Metadata extracted from the PDF document. 
    # This value is retained and returned as the return from the function. 
    docinfo = pdDocGetInfo(doc) 
    open(out, "w") do io
    
        # Returns number of pages in the document       
        npage = pdDocGetPageCount(doc)

        for i=1:npage
        
            # handle to the specific page given the number index. 
            page = pdDocGetPage(doc, i)
            
            # Extract text from the page and write it to the output file.
            pdPageExtractText(io, page)

        end
    end
    # Close the document handle. 
    # The doc handle should not be used after this call
    pdDocClose(doc)
    return docinfo
end