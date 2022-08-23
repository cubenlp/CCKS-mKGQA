# 数据分析例子

## 关系抽取
关系对齐
who **directed** the **theme** of NER?	the_lion_king_celebration	**theme**	**director**
who is the **predecessor** of the **coach** of NER	houston_rockets	**coach**	**before**
who is **before** the **coach** of NER?	portugal_national_football_team	**coach**	**before**
which **country** does the **notable work** of NER belong to?	philip_eisner	**notableworks**	**country**
who is **before** the **coach** of NER?	portugal_national_football_team	**coach**	**before**
who is the **predecessor** of the **coach** of NER?	danish_football_association	**coach**	**before**
which **country** does the **notable work** of NER belong to?	philip_eisner	**notableworks**	**country**

Next to 对齐到 alongside 
President of **Next to** NER	|	alongside	president
who will be next **Next to** NER	|	alongside	after
President of **Next to** NER	|	alongside	president
president of **Beside** NER	|	alongside	president
Premier of **Next to** NER	|	alongside	primeminister
who was the **Next to** NER before	|	alongside	before

lies in **west** of **county** NER belongs to	|	shirecounty	west
lies in **rel2** of **rel1** NER belongs to

1. 关系 => 在问题出现的形式 [rel1, rel2]
2. 从问题提取模板

## 多个三元组相同的情况
("zh", "模拟人生", "publisher", "美国艺电")
("zh", "模拟人生系列", "publisher", "美国艺电")
("en", "The_Sims", "publisher", "Electronic_Arts")]

## 存在的问题
可能的识别错误

NER, British architect, where is his famous work
Tom Wright (British architect)，英国建筑师，其成名作品在什么位置

NER, British architect, his famous work	|	notableworks	location


可能的错误原因
![翻译错误](https://cdn.jsdelivr.net/gh/zhihongecnu/PicBed3/picgo/翻译错误.png)
![wiki重定向](https://cdn.jsdelivr.net/gh/zhihongecnu/PicBed3/picgo/wiki重定向.png)



## 方法一，从问题到关系
### 例一，训练集-692
1. 原句：who is before the parent of 蔡智勇?
2. NER-翻译：who is before the parent of NER?
3. 去除停用词（当前）：before parent
4. 两跳关系（目标）：parents predecessor

关键步骤：根据步骤 3 到步骤 4 的信息构建字典

1. 词频匹配，统计带 before 的问题的两跳关系
"before"         => 102
"predecessor"    => 39
"related"        => 24
"after"          => 20
"commander"      => 18
"alongside"      => 18
"leader"         => 17
"after_election" => 16

2. 取频次较高的情况，得到 predecessor 与 before 匹配

3. 词性匹配或距离匹配，建立 parent 与 parents 的匹配
4. 词频匹配，得到与 parent 更接近的 parents，尽管 predecessor 也出现了，但这里已经分配给了 before
"parents"          => 331
"predecessor"      => 34
"title"            => 27

### 例二，训练集-2
1. 原句：what is the logo of the car that 茶裏王 is related to?
2. NER-翻译：what is the logo of the car that NER is related to?
3. 去除停用词：logo related
4. 两跳关系：related logo

精确匹配，一步到位

### 例三，训练集-4039
1. 原句：who leads the predecessor of the location of 2016 Guangzhou R&F FC season, a season of football team?
2. NER-翻译：who leads the predecessor of the location of NER
3. 去除停用词：leads predecessor location
4. 两条关系：location before leaderName

精确匹配 location => location
词频分析 
1. leads
"location"          => 19
"leader_name"       => 15
"leader"            => 10

2. predecessor
"before"       => 368
"predecessor"  => 227
"issue"        => 99
"after"        => 87
"title"        => 81
"stadium"      => 57
"successor"    => 55

3. location
"location"          => 768
"subdivision_name"  => 201
"subdivision_type"  => 185
"east"              => 158
"northwest"         => 146

最佳匹配：leads => leader_name, predecessor => before, location => location

### 可能问题
少量（≤1%）中文问题翻译后，丢失关系，比如
1. 原句：Bing's Hollywood vols.1-15的创作者是谁的上一任
2. NER-翻译：who is the creator of NER?
3. 去除单词：creator
4. 两跳关系：chronology after

当前策略：验证集如果遇到，提取后单独翻译。

