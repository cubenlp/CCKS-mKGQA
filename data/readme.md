## 训练数据集
(文件比较大，就不放仓库了)

1. train_data.txt
   训练集文件，包括14,262条问题，其中，中，英，法问题各4,000-5,000 条，每个问题对应有完整答案路径标注

2. valid_data.txt
   验证集文件，包括1,500条问题，其中，中、英、法问题各500条，不包含答案路径标注（需预测）

3. test_data.txt（缺）
   测试集文件，包括1,500条问题，其中，中、英、法问题各500条，不包含答案路径标注（需预测）


## 知识库
1. `Triples_zh.txt` 包含中文知识图谱的主要三元组。
2. `Triples_en.txt` 包含英语知识图谱的主要三元组。
3. `ILLs_zh_en.txt` 包含“中-英"跨语言图谱的已知实体对齐。

## 预处理文件
- [ILLs(zh-en).txt](http://qiniu.wzhecnu.cn/ccks/ILLs%28zh-en%29.txt)
- [triple_zh.txt](http://qiniu.wzhecnu.cn/ccks/triple_zh.txt)
- [triple_en.txt](http://qiniu.wzhecnu.cn/ccks/triple_en.txt)
- [train_data.txt](http://qiniu.wzhecnu.cn/ccks/train_data.txt)