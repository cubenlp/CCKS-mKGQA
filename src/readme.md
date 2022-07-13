# 代码简介
本目录下的代码均由 Julia 编写，分三个文件夹
| 文件夹 | 内容说明 |
| ----- | ------- |
| `lodadata` | 导入数据 |
| `process` | 流程依赖的脚本文件 |
| `tools` | 编写的 Julia 工具 |

## tools
1. `distance.jl` 计算字符距离的工具
2. `prefixtree.jl` 前缀树
3. `xlsx.jl` 与谷歌翻译交互的 Excel 工具

## process
1. `regexpr.jl` 数据预处理使用的正则表达式
2. `translate.jl` 问题与元组翻译
3. `ettalign.jl` 实体对齐，将 ILLs 文件展开
4. `submitpath.jl` 三元组还原和路径推理

## loaddata
1. `extractdata.jl` 导入预处理后的数据
2. `translatedata.jl` 导入翻译后的数据