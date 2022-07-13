1. 和关键字 **Ira Goldstein** 有关的三元组只有一个：
- `Ira_Goldstein	client	ASB_Bank` ，出现在 `triple_en.txt`
- `<http://dbpedia.org/resource/Ira_Goldstein> <http://dbpedia.org/property/client> <http://dbpedia.org/resource/ASB_Bank>`

2. 实体 `Ira_Goldstein` 和 `ASB_Bank` 没有其他三元组，也没有对齐关系

3. 验证集与实体 Ira_Goldstein 相关的问题（6个）：

- 10	what is the parent moutain of the client of **Ira Goldstein**?
- 99	where is the client of **Ira Goldstein** located?
- 760	**Ira Goldstein**的委托人属于哪个
- 836	**Ira Goldstein**的客户在什么位置
- 1047	Savez-vous d'où proviennent Client de **Ira Goldstein**
- 1097	Où est l’emplacement du Client de **Ira Goldstein**

<http://dbpedia.org/resource/ASB_Bank> <http://zh.dbpedia.org/property/location> <http://zh.dbpedia.org/resource/新西蘭>
<http://dbpedia.org/resource/ASB_Bank> <http://zh.dbpedia.org/property/parent> <http://dbpedia.org/resource/Commonwealth_Bank>


who is NER's father's successor?	princess_of_qingdu

who did a job before the parent of NER?	francis_russell,_marquess_of_tavistock

francis_russell,_marquess_of_tavistock	parents	john_russell,_4th_duke_of_bedford


9   which title does the parent of **富兰克林·德拉诺·罗斯福三世**, an american economist, belong to?
zh  **富兰克林·德拉诺·罗斯福三世**	parents	小富兰克林·德拉诺·罗斯福
en1  Franklin_Delano_Roosevelt_Jr.	title	New_York_State_Attorney_General
en2  Franklin_Delano_Roosevelt_Jr.	title	Governor_of_New_York

9	<http://zh.dbpedia.org/resource/富兰克林·德拉诺·罗斯福三世>#<http://zh.dbpedia.org/property/parents>#<http://zh.dbpedia.org/resource/小富兰克林·德拉诺·罗斯福>#<http://dbpedia.org/resource/Franklin_Delano_Roosevelt_Jr.>#<http://dbpedia.org/property/title>#<http://dbpedia.org/resource/Governor_of_New_York>

9	<http://zh.dbpedia.org/resource/富兰克林·德拉诺·罗斯福三世>#<http://zh.dbpedia.org/property/parents>#<http://zh.dbpedia.org/resource/小富兰克林·德拉诺·罗斯福>#<http://dbpedia.org/resource/Franklin_Delano_Roosevelt_Jr.>#<http://dbpedia.org/property/title>#<http://dbpedia.org/resource/New_York_State_Attorney_General>

9	<http://zh.dbpedia.org/resource/富兰克林·德拉诺·罗斯福三世>#<http://zh.dbpedia.org/property/parents>#<http://zh.dbpedia.org/resource/小富兰克林·德拉诺·罗斯福>#<http://dbpedia.org/resource/Franklin_Delano_Roosevelt_Jr.>#<http://dbpedia.org/property/title>#<http://dbpedia.org/resource/Governor_of_New_York>

# 训练集的 3 道数据，题目相同但答案不同
美国犹他州凯奇县的一座城市Logan, Utah北部的地点东南部的地点的区划是什么	Logan,_Utah
en	Logan,_Utah	north	Amalga,_Utah
en	Amalga,_Utah	southeast	Hyde_Park,_Utah
zh	海德公园_(犹他州)	subdivisionType	國家
zh	海德公园_(犹他州)	subdivisionType	犹他州行政區劃
zh	海德公园_(犹他州)	subdivisionType	美國行政區劃

# 图谱中的重边
新鐵金剛之不日殺機	starring	皮尔斯·布鲁斯南
新鐵金剛之不日殺機	starring	哈莉·贝瑞
新鐵金剛之不日殺機	starring	托比·斯蒂芬斯
新鐵金剛之不日殺機	starring	尹成植
新鐵金剛之不日殺機	starring	茱蒂·丹契
新鐵金剛之不日殺機	starring	羅莎蒙·派克
新鐵金剛之不日殺機	starring	曾江

龙胜各族自治县	東	兴安县
<http://dbpedia.org/resource/Longsheng_Various_Nationalities_Autonomous_County> <http://zh.dbpedia.org/property/東> <http://dbpedia.org/resource/Xing'an_County>

<a href="https://en.wikipedia.org/wiki/Longsheng_Various_Nationalities_Autonomous_County" title="Longsheng Various Nationalities Autonomous County – 英文" lang="en" hreflang="en" class="interlanguage-link-target"><span>English</span></a>

who **directed** the **theme** of NER?	the_lion_king_celebration	**theme**	**director**
who is the **predecessor** of the **coach** of NER	houston_rockets	**coach**	**before**
who is **before** the **coach** of NER?	portugal_national_football_team	**coach**	**before**
which **country** does the **notable work** of NER belong to?	philip_eisner	**notableworks**	**country**
who is **before** the **coach** of NER?	portugal_national_football_team	**coach**	**before**
who is the **predecessor** of the **coach** of NER?	danish_football_association	**coach**	**before**
which **country** does the **notable work** of NER belong to?	philip_eisner	**notableworks**	**country**


President of **Next to** NER	|	alongside	president

who will be next **Next to** NER	|	naomi_tokashiki	alongside	after
President of **Next to** NER	|	leonard_wilcox	alongside	president
president of **Beside** NER	|	john_henderson_(mississippi_politician)	alongside	president
Premier of **Next to** NER	|	naomi_tokashiki	alongside	primeminister
who was the **Next to** NER before	|	naomi_tokashiki	alongside	before


to  series belongs the Notable Works of NER	|	paul_barnett_(video_game_designer)	notableworks	series
where Election after NER	|	8th_national_people's_congress	afterelection	constituency
what are the products responsible for NER	|	world_teamtennis	sponsor	products
series the head of NER belongs to	|	royal_rumble_(2002)	sponsor	series
mother of The father of NER	|	princess_nittabe	father	mother
what are NER's Responsible Products	|	vengeance_(2005)	sponsor	products
father of NER Client	|	mariyinsky_palace	client	father
developer of The NER thing	|	nexus_6p	related	developer
profession of NER Chronology	|	duality_(lisa_gerrard_&_pieter_bourke_album)	chronology	profession
party belongs to Next to NER	|	john_henderson_(mississippi_politician)	alongside	party
what eponymous domain of NER belongs to	|	von_behring_(crater)	eponym	field


可能的识别错误
what language do the creators of Amy Skye, Beth Nelson Chapman, Olivia Newton John's album NER speak	liv_on	chronology	language

NER, British architect, where is his famous work
NER, British architect, his famous work	|	notableworks	location


successor of successor of NER

lies in **west** of **county** NER belongs to	|	shirecounty	west
lies in **rel2** of **rel1** NER belongs to

1. 关系 => 在问题出现的形式 [rel1, rel2]
2. 从问题提取模板