--9 Тригъри
--Показва имената на изтритите експонати и музеите, в които са били съхранявани

if exists (select 1
			 from sys.objects
			where type = 'TR'
			  and name = 'delete_exhibit_name')
	drop trigger delete_exhibit_name;
GO

CREATE TRIGGER delete_exhibit_name ON EXHIBIT FOR DELETE AS
BEGIN
	select NAME, MUSEUM_NAME 
	from deleted;
END;
