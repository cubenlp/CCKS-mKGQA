# CCKS-mKGQA contest

[中文说明](README-zh-cn.md)

> [official link](https://www.biendata.xyz/competition/clkgqa/)

## How to use
The main part of the code in this repository is writing in Julia.

Install requirements.
```jl
using Pkg
Pkg.activate(".") ## path to this repo
Pkg.update()
```

After installation, following the instructions provided by the Jupyter notebooks at `./dataprocess`.

## Contest background
As more and more non-English users have participated in the establishment and maintenance of knowledge graphs in recent years, the distribution of online knowledge has changed from a single language rich in resources (English) to complementary multilingual resources. However, current multilingual knowledge graph question answering models mainly focus on natural language question parsing, while ignoring the joint application of cross-lingual knowledge.
 

Taking the Encyclopedia Knowledge Questions and Answers as an example, for emerging knowledge, such as "COVID-19 (2019 novel coronavirus disease)", in the Chinese Wikipedia entry, the record about the attribute of "complication" contains "systemic organ failure", and this Item records are not included in the English entry for "Complication". On the other hand, the English entry contains the attribute of "Duration (duration of symptoms)", but the Chinese entry lacks the collection of this attribute. Therefore, such as: "Coronavirus that can cause the complication of systemic organ failure, how long does it usually cause symptoms in the human body?", "Symptoms generally last more than five days, and may become chronic coronavirus, Is it possible to cause serious complications such as systemic organ failure?" For such questions that require joint cross-language knowledge, the current question answering system is difficult to answer.
 

The goal of this evaluation task is to use the cross-language knowledge graph to answer questions raised in different languages. We expect the contestants’ question answering system to not only solve the lexical gap between natural language questions and knowledge graphs, but also to be accurate in the cross-language knowledge graph. Find the combination of knowledge relevant to the problem.
 

## game task
The competition requires the contestants to use the given knowledge graph resources, train the algorithm model according to the question-and-answer data provided in the training set, and generate automatic answer paths for the questions in the validation set.
Model input: The input file contains several lines of natural language questions.
Model output: Each line of the output file corresponds to the answer path of a question. The elements in the list are separated by \t, and the path elements are separated by the separator #.
 
Input Example
```md
q1: To which institution is the alma mater of Iranian American artist and educator Taravat Talepasand affiliated?
q2: Who does the person whose name is used to name Poe (crater) influence?
```

Output Sample:

a1:
<http://dbpedia.org/resource/Taravat_Talepasand>#<http://dbpedia.org/property/almaMater>#<http://dbpedia.org/resource/Rhode_Island_School_of_Design>#<http://zh.dbpedia.org/resource/罗德岛设计学院>#<http://zh.dbpedia.org/property/state>#<http://zh.dbpedia.org/resource/罗德岛州>
a2:
<http://dbpedia.org/resource/Poe_(crater)>#<http://dbpedia.org/property/eponym>#<http://dbpedia.org/resource/Edgar_Allan_Poe>#<http://zh.dbpedia.org/resource/爱伦·坡>#<http://zh.dbpedia.org/property/influenced>#<http://zh.dbpedia.org/resource/江户川乱步>