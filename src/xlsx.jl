using XLSX

function write_xlsx(filename::AbstractString, vector::AbstractVector)
    XLSX.openxlsx(filename, mode="w") do xf
        sheet = xf[1]
        n = length(vector)
        sheet["A1:A$n"] = reshape(vector, n, 1)
    end
end

function write_xlsx(filename::AbstractString, mat::AbstractMatrix)
    XLSX.openxlsx(filename, mode="w") do xf
        m, n = size(mat)
        sheet = xf[1]
        sheet["A1:$(excel_colind(n))$m"] = mat
    end
end

function excel_colind(k::Int)
    @assert k <= 2 ^ 14 "列数超过范围"
    (k -= 1) <= 25 && return 'A' + k
    (k -= 26) <= 26 ^ 2 - 1 && return ('A' + k ÷ 26) * ('A' + k % 26)
    join('A' + i for i in reverse!(digits(k - 26 ^ 2, base = 26, pad=3)))
end

# 只针对一维数据。。。
function read_xlsx(filename)
    data = XLSX.readxlsx(filename)[1][:]
    m, n = size(data)
    string.(n == 1 ? data[:] : data) # 单行返回向量，多行返回矩阵
end
