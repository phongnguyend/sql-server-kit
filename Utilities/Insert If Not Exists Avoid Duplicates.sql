-- https://devblogs.microsoft.com/azure-sql/the-insert-if-not-exists-challenge-a-solution/

create table [dbo].[tags] ( 
    [post_id] int not null, 
    [tag] nvarchar(50) not null, 
    constraint pk__tags primary key clustered ([post_id], [tag]) 
)

-- fist option
insert into [dbo].[tags] ([post_id], [tag]) 
select * from ( 
    values (10, 'tag123') -- sample value 
) as s([post_id], [tag]) 
where not exists ( 
    select * from [dbo].[tags] t with (updlock) 
    where s.[post_id] = t.[post_id] and s.[tag] = t.[tag] 
)

-- second option
merge into 
    [dbo].[tags] with (holdlock) t  
using 
    (values (10, 'tag1233')) s([post_id], [tag]) 
on 
    t.[post_id] = s.[post_id] and t.[tag] = s.[tag] 
when not matched then 
    insert values (s.[post_id], s.[tag]);
