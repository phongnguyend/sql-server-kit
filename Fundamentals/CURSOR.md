```sql
DECLARE @tblStudent table(Name varchar(50), Age int);
insert into @tblStudent(Name,Age) values('Name 1',1)
insert into @tblStudent(Name,Age) values('Name 2',2)

DECLARE @name VARCHAR(50) 
DECLARE @age int

DECLARE myCursor CURSOR FOR  
SELECT Name, Age
FROM @tblStudent

OPEN myCursor   
FETCH NEXT FROM myCursor INTO @name,@age  

WHILE @@FETCH_STATUS = 0   
BEGIN   
       print(@name + ' - ' + cast(@age as varchar))
       FETCH NEXT FROM myCursor INTO @name ,@age 
END   

CLOSE myCursor   
DEALLOCATE myCursor
```
