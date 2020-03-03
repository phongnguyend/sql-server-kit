
declare @tables table(name varchar(100) primary key)
insert into @tables
select name
from sys.tables
order by name

select 'public class TableNames'
union all
select '{'
union all
select 'public const string ' + name + ' = "' + name + '";' 
from @tables
union all
select '}'
