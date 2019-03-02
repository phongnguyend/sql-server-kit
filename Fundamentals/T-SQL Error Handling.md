### 1. RAISERROR
```sql
-- User-defined message using msg_str, severity level 16, state 1
RAISERROR ('This is our user-defined error message, severity 16!', 
		16, 1);

-- User-defined message using msg_str, severity level 0, state 1
-- Informational messages with severity <= 10
RAISERROR ('This is our user-defined error message, severity 0!', 
		10, 1);

-- User-defined message using msg_str, severity level 11, state 1
RAISERROR ('This is our user-defined error message, severity 11!', 
		11, 1);

-- User-defined message using msg_str, severity level 19, state 1
-- Will it work?
RAISERROR ('This is our user-defined error message, severity 19!', 
		19, 1) WITH LOG;

-- What happens with severity level 20 and up?
RAISERROR ('This is our user-defined error message, severity 20!', 
		20, 1) WITH LOG;

-- We can also use a local variable
DECLARE @error_msg VARCHAR(2044) = 'This is our user-defined error message, severity 16!';
RAISERROR (@error_msg, 16, 1);
GO

-- Using character substitution
	-- d or i for signed integer
	-- o for unsigned octal
	-- s for string
	-- u for unsigned integer
	-- x or X for unsigned hexadecimal
RAISERROR ('%i rows were expected from the %s table in the %s database.', 16, 1,
			20, 'dbo.Order', 'Credit');

-- What happens if you exceed 2,047 characters?
DECLARE @error_msg VARCHAR(2048) = 
  REPLICATE('This message is too long and you will see an ellipsis. ',
                                             2048);

RAISERROR (@error_msg, 16, 1);
GO
```
### 2. TRY CATCH
### 3. @@ERROR
```sql
-- Custom error message, severity 16
RAISERROR ('Sample error', 16, 1);
PRINT @@ERROR;
GO

-- Custom error message, severity 10, any error number?
RAISERROR ('Sample error', 10, 1);
PRINT @@ERROR;
GO

-- @@ERROR lifecycle and preservation
SELECT 1/0;
IF @@ERROR > 0
	-- Returns 0 if the previous statement encountered no errors
	PRINT @@ERROR;
GO

-- @@ERROR lifecycle and preservation comparison
SELECT 1/0;
DECLARE @Error INT = @@ERROR;
IF @Error > 0
	PRINT @Error;
GO
```
### 4. ERROR_LINE(), ERROR_MESSAGE(), ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_PROCEDURE();
### 5. THROW
### 5. Transaction Handling and TRY CATCH

