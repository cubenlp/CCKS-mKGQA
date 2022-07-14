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

部分问题翻译后丢失
![深度截图_选择区域_20220714081134](https://cdn.jsdelivr.net/gh/zhihongecnu/PicBed3/picgo/深度截图_选择区域_20220714081134.png)