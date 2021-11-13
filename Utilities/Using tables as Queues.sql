----------
-- http://rusanu.com/2010/03/26/using-tables-as-queues/

-- Heap Queues:
create table HeapQueue (
  Payload varbinary(max));
go
 
create procedure usp_enqueueHeap
  @payload varbinary(max)
as
  set nocount on;
  insert into HeapQueue (Payload) values (@Payload);
go
 
create procedure usp_dequeueHeap 
as
  set nocount on;
  delete top(1) from HeapQueue with (rowlock, readpast)
      output deleted.payload;      
go

-- FIFO Queues:
create table FifoQueue (
  Id bigint not null identity(1,1),
  Payload varbinary(max));
go
 
create clustered index cdxFifoQueue on FifoQueue (Id);
go
 
create procedure usp_enqueueFifo
  @payload varbinary(max)
as
  set nocount on;
  insert into FifoQueue (Payload) values (@Payload);
go
 
create procedure usp_dequeueFifo
as
  set nocount on;
  with cte as (
    select top(1) Payload
      from FifoQueue with (rowlock, readpast)
    order by Id)
  delete from cte
    output deleted.Payload;
go

-- Subquery deque plan:
delete top(1) from FifoQueue
output deleted.Payload
where Id = (
select top(1) Id
  from FifoQueue with (rowlock, updlock, readpast)
order by Id)

-- LIFO Stacks:
with cte as (
    select top(1) Payload
      from FifoQueue with (rowlock, readpast)
    order by Id DESC)
  delete from cte
    output deleted.Payload;

-- Pending Queues:
create table PendingQueue (
  DueTime datetime not null,
  Payload varbinary(max));
 
create clustered index cdxPendingQueue on PendingQueue (DueTime);
go
 
create procedure usp_enqueuePending
  @dueTime datetime,
  @payload varbinary(max)
as
  set nocount on;
  insert into PendingQueue (DueTime, Payload)
    values (@dueTime, @payload);
go
 
create procedure usp_dequeuePending
as
  set nocount on;
  declare @now datetime;
  set @now = getutcdate();
  with cte as (
    select top(1) 
      Payload
    from PendingQueue with (rowlock, readpast)
    where DueTime < @now
    order by DueTime)
  delete from cte
    output deleted.Payload;
go

----------
