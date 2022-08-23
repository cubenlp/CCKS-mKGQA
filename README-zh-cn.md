# CCKS2022：跨语言知识图谱问答

## 使用方法
本仓库主要语言为 Julia（不包括外链仓库），[下载及安装](https://julialang.org/downloads/)。

安装依赖
```jl
using Pkg
Pkg.activate(".") ## path to this repo
Pkg.update()
```

代码使用说明参考 dataporcess 目录下的[Jupyter Notebooks](./dataprocess)。

## 竞赛描述
1. 比赛平台网址：
    [CCKS2022: Question Answering over Cross-lingual Knowledge Graphs - Biendata](https://www.biendata.xyz/competition/clkgqa/)

2. 任务五：跨语言知识图谱问答评测任务
    [评测任务 – 2022全国知识图谱与语义计算大会](http://sigkg.cn/ccks2022/?page_id=22)

3. 要点：
   - 解决自然语言问题与知识图谱间的**词法鸿沟问题**
   - 在跨语言知识图谱中准确找到问题相关的知识组合

4. 比赛任务
   - 比赛要求选手根据提供的训练集问答数据**训练算法模型**并对验证集中的问题进行**自动答案路径生成**
   - 模型输入：输入文件包含若干行自然语言问句
   - 模型输出：输出文件每一行对应一个问题的答案路径，列表内元素以\t分隔，路径元素由分隔符#隔开

5. 最终提交文件要求：
   - 问答任务测试集结果文件，用 result.txt 命名（UTF-8格式）
   - 相关代码及说明
   - 方法描述文档（非评测论文，评测论文撰写要求见CCKS 2022官网）

6. 以上三个文件需在任务提交截止日期前发送至邮箱 tt_yymm@seu.edu.cn（暂定），邮件的标题为："CCKS-CLKGQA-参赛队名称"。

## 时间安排

| 事项 | 时间 |
| :---: | :---: |
| 任务征集截止时间 | 3月24日 |
| 任务准备时间 | 3月25日—4月6日 |
| 评测任务发布时间 | 4月6日 |
| 报名时间 | 4月6日—7月25日 |
| 训练及验证数据发布时间 | 4月25日 |
| 测试数据发布时间 | 7月25日 |
| 提交测试结果时间 | 7月31日 |
| 评测论文提交时间 | 8月12日 |
| CCKS会议日期(评测报告及颁奖) | 8月25日—28日 |

比赛代码参见 `dataprocess` 的 jupyter-notebook 文件。