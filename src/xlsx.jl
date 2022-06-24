using XLSX

function write_xlsx(filename::AbstractString, vector::AbstractVector)
    XLSX.openxlsx(filename, mode="w") do xf
        sheet = xf[1]
        n = length(vector)
        sheet["A1:A$n"] = reshape(vector, n, 1)
    end
end

read_xlsx(filename) = Vector{String}(strip.(XLSX.readxlsx(filename)[1][:][:]))
