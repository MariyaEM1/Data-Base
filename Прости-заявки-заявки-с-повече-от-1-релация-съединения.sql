--3.1. Show the address of the museums with type art, historic
select m.ADDRESS 
from MUSEUM m
where m.type='art, historic'

--3.2. Show the directors of the museums and the names of the museums 
select e.NAME, e.MUSEUM_NAME
from EMPLOYEE e
where e.POSITION='Director'

--3.3. Show the ID and type of the items which count is bigger than 600 and price less than 10
select i.ID, i.TYPE
from ITEM i
where i.COUNT>600 and i.PRICE<10

--3.4. Show the type and museums which address is ending on London or York and aren't historic
select m.NAME, m.TYPE 
from MUSEUM m
where m.type!='art, historic' and m.ADDRESS like '%London' or m.ADDRESS like '% New York'

--3.5. Show the id and the country of the exhibits which year is 2600, condition is bigger than 1 and the country doesnt start with G
select ex.ID, ex.COUNTRY
from EXHIBIT ex
where ex.year = 2600 and ex.CONDITION>1 and ex.COUNTRY not like 'G%'

--3.6. Show the names of museums and types of items which at least 2 of them are with the same count and price, ordered by the names of the museums
select distinct i1.MUSEUM_NAME, i1.TYPE
from ITEM i1, ITEM i2
where i1.COUNT=i2.COUNT and i1.PRICE=i2.PRICE
order by 1,2

--3.7. Show the name of the exhiitions, museums in which the name of exhibition is Russian art and the number of visitors is bigger than 500
select distinct ex. NAME, m.Name
from MUSEUM m, VISITORS v, EXHIBITION ex
where ex.MUSEUM_NAME=m.NAME and m.NAME=v.MUSEUM_NAME and ex.NAME='Russian art' and v.VISITORS_COUNT>500

--3.8. Show directors of the museums without audio guide but with the best condition of exhibits 
select em.NAME, em.MUSEUM_NAME
from EMPLOYEE em, EXHIBIT e
where em.position='Director'and e.MUSEUM_NAME=em.MUSEUM_NAME and e.CONDITION=1
except
select em.Name, em.MUSEUM_NAME
from EMPLOYEE em, ITEM i
where i.MUSEUM_NAME=em.MUSEUM_NAME and i.TYPE='audio guide'
order by 2
--3.9. Show the directors of the museums with at least 2 exhibitions with the same exhibit count 
select em.salary, em.NAME
from MUSEUM m, EXHIBITION ex1, EXHIBITION ex2, EMPLOYEE em
where ex1.exhibit_count=ex2.exhibit_count and ex1.NAME!=ex2.NAME and ex1.MUSEUM_NAME=m.NAME and ex2.MUSEUM_NAME=m.NAME and m.NAME=em.MUSEUM_NAME and em.position='Director'

--3.10.Show the websites of all museums in New York and all museums with the salary of emplayees = 8960 
select m.website
from MUSEUM m, EMPLOYEE em
where m.NAME=em.MUSEUM_NAME and em.SALARY=8960
union 
select m.website
from MUSEUM m
where m.ADDRESS like '%New York%'


--5.1. Show the names and conditions of the exhibits in the museums with most visitors
select e.NAME, e.CONDITION
from VISITORS v 
	join MUSEUM m on m.NAME=v.MUSEUM_NAME
	join EXHIBITION ex on m.NAME=ex.MUSEUM_NAME
	join EXHIBIT e on ex.MUSEUM_NAME= e.MUSEUM_NAME
where v.VISITORS_COUNT>=ALL(select VISITORS_COUNT
							from VISITORS)
order by 2

--5.2. Show the name, address and type of the museum with no visitors or without any souvenirs
select m.NAME, m.ADDRESS, m.TYPE
from MUSEUM m 
left join (select v.VISITORS_COUNT, v.MUSEUM_NAME
			from VISITORS v
			union all
			select i.COUNT, i.MUSEUM_NAME
			from ITEM i
			where i.TYPE='souvenir')wthout
		on wthout.MUSEUM_NAME=m.NAME
where wthout.VISITORS_COUNT is null

--5.3. Show the count of visitors if it is bigger than the number of audio guides in the museum
select v.VISITORS_COUNT, v.MUSEUM_NAME, i.PRICE, i.COUNT
from VISITORS v 
	inner join item i
	on v.VISITORS_COUNT>=i.COUNT and i.MUSEUM_NAME=v.MUSEUM_NAME and i.TYPE='audio guide'
order by 3, 4

--5.4. Show the name, website and type of the museums whichis not historic are established before 1880, the count of exhibits is less than 10 
select distinct t1.NAME, t1.WEBSITE, t1.TYPE
from (select m.NAME, m.ESTABLISHED, m.WEBSITE, m.TYPE
	from EXHIBITION ex cross join MUSEUM m
	where ex.EXHIBIT_COUNT>=5000 and ex.MUSEUM_NAME=m.NAME
	)t1
	inner join(select m.ESTABLISHED
				from MUSEUM m
				where m.ESTABLISHED<=1880) t2
			on t1.ESTABLISHED=t2.ESTABLISHED
where t1.TYPE ='art'
order by 1

--5.5. Show the age and condition which are the same in at least 2 of the exhibitits
select distinct e1.AGE, e1.CONDITION
from EXHIBIT e1 
	join EXHIBIT e2 on e1.AGE=e2.AGE 
					and e1.CONDITION=e2.CONDITION
					and e1.ID!=e2.ID