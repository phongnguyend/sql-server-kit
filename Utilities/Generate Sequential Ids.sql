create table #temp(Id uniqueidentifier default NEWSEQUENTIALID(), Value int)
insert into #temp(Value) values
(0),(0),(0),(0),(0),(0),(0),(0),(0),(0)
select Id from #temp order by Id
drop table #temp;
