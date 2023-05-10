--9 Тригъри
--Проверка на данните при експонатите дали са валидни при промяна

if exists (select 1
			 from sys.objects
			where type = 'TR'
			  and name = 'check_data')
	drop trigger check_data;
GO

CREATE TRIGGER check_data ON EXHIBIT FOR UPDATE AS
BEGIN
	declare @new_condition as INT;
	select @new_condition = CONDITION from inserted;

	declare @new_age as char(2);
	select @new_age = AGE from inserted;

	declare @new_year as INT;
	select @new_year = YEAR from inserted;

	if (@new_condition < 1 or @new_condition > 5)
	begin
		print 'New condition is out of range (1-5)!';
		Rollback;
	end;

	if (@new_age != 'AD' and @new_age != 'BC')
	begin
		print 'New age is incorrect! There are two correct values: AD or BC';
		Rollback;
	end;

	if (@new_year > 2022 and @new_age = 'AD')
	begin
		print 'New year is incorrect!';
		Rollback;
	end;
END;

