SELECT o.name, o.xtype, m.definition, m.uses_ansi_nulls, m.uses_quoted_identifier
FROM sys.sql_modules  m  
INNER JOIN sysobjects o ON m.object_id = o.id 
WHERE m.definition LIKE '%xxx%' 