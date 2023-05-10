--9 Тригъри
--Проверка на телефонните номера на служителите дали са валидни при промяна

if exists (select 1
			 from sys.objects
			where type = 'TR'
			  and name = 'check_data_employee')
	drop trigger check_data_employee;
GO

CREATE TRIGGER check_data_employee ON EMPLOYEE FOR UPDATE AS
BEGIN
	declare @new_telnumber as CHAR(10);
	select @new_telnumber = TELEPHONE from inserted;
	IF ( PATINDEX ('%[^0-9]%', @new_telnumber) > 0 )
	BEGIN
		PRINT 'Incorrect telephone number!';
		Rollback;
	END
END;
