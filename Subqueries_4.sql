--4 Subqueries

--1 Извежда име на музей, година на носноваване и адрес на музеят, където е експоната Мона Лиза на Леонардо Давинчи
SELECT M.NAME Museum, M.ESTABLISHED Established, M.ADDRESS Address
FROM MUSEUM M
WHERE NAME = (SELECT E.MUSEUM_NAME 
					FROM EXHIBIT E
					WHERE E.NAME = '"Mona Lisa" by Leonardo da Vinci');

--2 Извежда името, уебсайта и броя работници на музеите, основани преди годината на основаване на Лувъра
SELECT M.NAME Name, M.WEBSITE Website, M.EMPLOYEE Employee
FROM MUSEUM M
WHERE M.ESTABLISHED < ANY(SELECT E.YEAR 
					FROM EXHIBIT E
					WHERE E.MUSEUM_NAME = 'Louvre');

--3 Извежда всичката информация за изложбата, чието име съвпада с изложба  1300г.
SELECT *
FROM EXHIBITION  E
WHERE E.NAME = (SELECT EX.EXHIBITION_NAME 
					FROM EXHIBIT EX
					WHERE EX.YEAR = 1300);

--4 Извежда всичката информация за изложбата, която е в музея с име Metropolitan Museum of Art
SELECT *
FROM EXHIBIT E
WHERE E.MUSEUM_NAME = (SELECT M.NAME 
					FROM MUSEUM M
					WHERE M.NAME = 'Metropolitan Museum of Art');

--5 Извежда име, уебсайт и брой работници на музей с, чиито брой работници е по-голям от всички музей с с повече от 100 работници
SELECT M.NAME Name, M.WEBSITE Website, M.EMPLOYEE Employee
FROM MUSEUM M
WHERE M.EMPLOYEE > ANY(SELECT MU.EMPLOYEE
						FROM MUSEUM MU
						WHERE MU.EMPLOYEE  >= 100)
ORDER BY EMPLOYEE DESC
 