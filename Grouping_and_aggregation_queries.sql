--6 Grouping and aggregation

--1 Извежда интернет страницата на музеите, посещавани от над половин милион души средно на ден
select m.WEBSITE, AVG(v.VISITORS_COUNT) AvgVisitors
from VISITORS v
join MUSEUM m on m.NAME = v.MUSEUM_NAME 
group by m.WEBSITE
having AVG(v.VISITORS_COUNT) > 500000

--2  Извежда имената на музеите, които съхраняват експонати от преди Христа 
select m.NAME
from EXHIBIT e
join MUSEUM m on m.NAME = e.MUSEUM_NAME 
where e.AGE = 'BC'
group by m.NAME

--3 Извежда имената на музеите, които съхраняват поне 5 експоната от Средновековието 
select m.NAME
from EXHIBIT e
join MUSEUM m on m.NAME = e.MUSEUM_NAME 
where e.YEAR > 395 and e.YEAR < 1453
group by m.NAME
having count(e.NAME) >= 5

--4 Извежда броя и общата им цена на всички продукти и услуги, които посетител може да си купи от съответния музей
select m.name, count(i.PRICE) as NumOfProducts, SUM(i.PRICE) as SumOfAllProducts 
from ITEM i
join MUSEUM m on i.MUSEUM_NAME = m.NAME
group by m.NAME

--5 Извежда държавите с над 5 експоната
select e.COUNTRY
from EXHIBIT e
join MUSEUM m on m.NAME = e.MUSEUM_NAME
group by e.COUNTRY
having count(m.NAME) > 5

--6 Извежда имената на изложбите, които са били посещавани общо от над 3 000 000 посетители 
select e.NAME
from EXHIBITION e join (select m.NAME
						from MUSEUM m JOIN VISITORS v on m.NAME = MUSEUM_NAME 
						group by m.NAME
						having SUM(v.VISITORS_COUNT) > 3000000) m 
on m.NAME = e.MUSEUM_NAME
group by e.NAME

--7 Извежда продуктите и услугите на музея, чиито служители взимат най-голяма средна заплата

select i.TYPE, i.MUSEUM_NAME
from ITEM i join
	(select e1.MUSEUM_NAME, AVG(e1.SALARY) avg_salary
	from EMPLOYEE e1
	group by e1.MUSEUM_NAME
	) e on i.MUSEUM_NAME = e.MUSEUM_NAME 
where e.avg_salary = 
(select MAX (t.avg_salary)
from
	( select m.NAME, AVG (e.SALARY) avg_salary
	from MUSEUM m join EMPLOYEE e on m.NAME = e.MUSEUM_NAME
	group by m.NAME		
	) t
)

