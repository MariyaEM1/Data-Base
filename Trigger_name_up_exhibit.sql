--9 Тригъри
--Уголемяване на буквите за по-добра четимост след въвеждане в таблицата

if exists (select 1
			 from sys.objects
			where type = 'TR'
			  and name = 'exhibit_up_name')
	drop trigger exhibit_up_name;
GO

CREATE TRIGGER exhibit_up_name ON exhibit AFTER INSERT AS
BEGIN
UPDATE EXHIBIT SET NAME = UPPER(NAME);
UPDATE EXHIBIT SET MUSEUM_NAME = UPPER(MUSEUM_NAME);
UPDATE EXHIBIT SET EXHIBITION_NAME = UPPER(EXHIBITION_NAME);
UPDATE EXHIBIT SET COUNTRY = UPPER(COUNTRY);
END
