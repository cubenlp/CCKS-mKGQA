cd(Base.source_dir())
sols = split(strip(read(open("predict_data.txt", "r"), String)), '\n')

include("../src/CCKS-mKGQA.jl")
include("../src/extractdata.jl")
include("../src/translatedata.jl")
include("../src/ettalign.jl")
include("../src/distance.jl")
include("../src/submitpath.jl")

# 读取预测结果

temp = submit(sols[1])
fails = String[]
println("正在开始提交问题答案")
open("submit/to_submit_$(submit_id).txt", "w") do io
    println(io, "id\tans_path")
    for (i, predict) in enumerate(sols)
        line = temp
        try
            line = submit(predict)
        catch
            # 没有合适解的情况
            push!(fails, predict)
        end
        println(io, i-1, '\t', line)
    end
end
println("路径推理失败的题目有 $(length(fails)) 道")