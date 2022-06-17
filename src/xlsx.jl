using XLSX

# example of writing a file
XLSX.openxlsx("my_new_file.xlsx", mode="w") do xf
    sheet = xf[1]
    sheet["A1"] = "this"
    sheet["A2"] = "is a"
    sheet["A3"] = "new file"
    sheet["A4"] = 100

    # will add a row from "A5" to "E5"
    sheet["A5"] = collect(1:5) # equivalent to `sheet["A5", dim=2] = collect(1:4)`

    # will add a column from "B1" to "B4"
    sheet["B1", dim=1] = collect(1:4)

    # will add a matrix from "A7" to "C9"
    sheet["A7:C9"] = [ 1 2 3 ; 4 5 6 ; 7 8 9 ]
end