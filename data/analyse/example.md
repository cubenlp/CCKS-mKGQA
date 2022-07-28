模板-2
```jl
r"which (?P<men2>.*) does the (?P<men1>.*) of NER belong to\?"
```

which affiliation does the alma mater of NER belong to?
1885 Dict("alma mater" => "alma_mater", "affiliation" => "affiliations")

which league does the controller of NER belong to?
1917 Dict("controller" => "controlledby", "league" => "league")

which title does the cause of NER belong to?
393	Dict("cause" => "result", "title" => "title_leader")


which type does the data source of NER belong to?
1221	Dict("data source" => "s", "type" => "type")

which administrative region does the archipelago of NER belong to?
7448	Dict("archipelago" => "archipelago", "administrative region" => "country_admin_divisions")


what is the name of the administrative district of **Eastern** Site of NER
UHOP
en	2016–17_Southern_Utah_Thunderbirds_men's_basketball_team	home	Monroe,_Utah
en	Monroe,_Utah	south	Kingston,_Utah
zh	金士顿_(犹他州)	subdivisionName	美利堅合眾國
BERTSIM
en	2016–17_Southern_Utah_Thunderbirds_men's_basketball_team	home	Saratoga_Springs,_Utah
en	Saratoga_Springs,_Utah	**east**	Vineyard,_Utah
zh	葡萄园_(犹他州)	subdivisionName	美利堅合眾國

what is the **occupation** of the **lyricist** of the title of NER?	Hero_(Super_Junior_album)
UHOP
en	Hero_(Super_Junior_album)	title	Perfection_(EP)
zh	尽善尽美	starring	海伦·亨特
zh	海伦·亨特	spouse	汉克·阿扎里亚
BERTSIM
en	Hero_(Super_Junior_album)	title	I_Wanna_Dance
en	I_Wanna_Dance	**lyrics**	Henry_Lau
zh	劉憲華	**職業**	歌手

which **region** does the event involved in NER belong to?	Tanukhids
UHOP
en	Tanukhids	event	First_Crusade
zh	第一次十字军东征	partof	十字軍東征
BERTSIM
en	Tanukhids	event	First_Crusade
zh	第一次十字军东征	**territory**	耶路撒冷王國

which type does the **southwest** of the **address** of NER belong to?	Pim_Futhun
UHOP
zh	皮姆·富圖恩	**deathPlace**	希尔弗瑟姆
en	Hilversum	subdivisionType	List_of_sovereign_states
BERTSIM
zh	皮姆·富圖恩	**residence**	鹿特丹
en	Rotterdam	**southwest**	Westvoorne

Pim_Futhun
 ("residence", "Rotterdam")
 ("**death_place**", "Hilversum")
 ("religion", "St._Jehoshaphat_Roman_Catholic_Church_(Chicago)")
 ("title", "Public_body_(Netherlands)")
 ("title", "Pim_Fortuyn_List")


 35	<http://zh.dbpedia.org/resource/天津泰达足球俱乐部2012赛季>#<http://zh.dbpedia.org/property/location>#<http://zh.dbpedia.org/resource/广州>
 #<http://dbpedia.org/resource/2012_Tianjin_Teda_F.C._season>#<http://dbpedia.org/property/location>#<http://dbpedia.org/resource/Guangzhou>#<http://dbpedia.org/resource/Guangzhou>#<http://dbpedia.org/property/northeast>#<http://dbpedia.org/resource/Zhaoqing>#<http://zh.dbpedia.org/resource/肇庆市>#<http://zh.dbpedia.org/property/location>#<http://zh.dbpedia.org/resource/端州区>


where is the location of the Northeast NER location	2012_Tianjin_Teda_FC_season



## WIKI 相对更准确
NER, the early dynastic confederation of ancient Egypt (c. 3150 AD), who was its leader's predecessor	Thinite_Confederacy
WIKI
en	Thinite_Confederacy	leader	Menes
zh	美尼斯	predecessor	那爾邁
ILL4
en	Thinite_Confederacy	leader	**Menes**
zh	**那尔迈**	predecessor	蝎子王

### 更完整
where is the iconic location of the same name of NER	French_ship_Polyphemus_(1815)
WIKI
en	French_ship_Polyphème_(1815)	shipNamesake	**Holland**
zh	**荷蘭_(地區)**	subdivisionType	主权国家
ILL4
NONE

what is the religion of the leaders of NER?	London_local_elections,_2018
WIKI
en	London_local_elections,_2018	leader	Tim_Farron
zh	蒂姆·法隆	title	自由民主党_(英国)
ILL4
NONE

which party belongs to Election after NER	Estonian_election_election,_2003
en	Estonian_parliamentary_election,_2003	afterElection	Juhan_Parts
zh	尤汉·帕茨	party	爱沙尼亚共和国党