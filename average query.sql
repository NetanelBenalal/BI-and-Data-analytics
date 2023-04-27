create table excelData(
Area varchar (50),
Skill varchar(50),
[2018] float,
[2019] float,
[2020] float,
[2021] float,
[2022] float
)
truncate table excelData
insert into excelData
select o.Area, t.skill, [2018] = (select [total income] = isnull(sum(oo.[total price]),0)
								from DWH_F_Orders as oo join DWH_D_TaskersType2 as tt 
								on tt.DWTasker = oo.tasker
								where o.Area = oo.area and tt. skill= t.skill and year(oo.[order date]) = '2018'
								) ,
							[2019] = (select [total income] = isnull(sum(oo.[total price]),0)
								from DWH_F_Orders as oo join DWH_D_TaskersType2 as tt 
								on tt.DWTasker = oo.tasker
								where o.Area = oo.area and tt. skill= t.skill and year(oo.[order date]) = '2019'
								) ,
							[2020] = (select [total income] = isnull(sum(oo.[total price]),0)
								from DWH_F_Orders as oo join DWH_D_TaskersType2 as tt 
								on tt.DWTasker = oo.tasker
								where o.Area = oo.area and tt. skill= t.skill and year(oo.[order date]) = '2020'
								) ,
							[2021] = (select [total income] = isnull(sum(oo.[total price]),0)
								from DWH_F_Orders as oo join DWH_D_TaskersType2 as tt 
								on tt.DWTasker = oo.tasker
								where o.Area = oo.area and tt. skill= t.skill and year(oo.[order date]) = '2021'
								) ,
							[2022] = (select [total income] = isnull(sum(oo.[total price]),0)
								from DWH_F_Orders as oo join DWH_D_TaskersType2 as tt 
								on tt.DWTasker = oo.tasker
								where o.Area = oo.area and tt. skill= t.skill and year(oo.[order date]) = '2022'
								) 
from DWH_F_Orders as o join DWH_D_TaskersType2 as t on t.DWTasker = o.tasker 
group by o.area, t.skill