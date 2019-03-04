-- Targets
SELECT  [p].[name] AS package_name,
        [o].[name] AS target_name,
        [o].[description]
FROM    [sys].[dm_xe_packages] AS p
INNER JOIN [sys].[dm_xe_objects] AS o
        ON [p].[guid] = [o].[package_guid]
WHERE   ([p].[capabilities] IS NULL OR
         [p].[capabilities] & 1 = 0) AND
        ([o].[capabilities] IS NULL OR
         [o].[capabilities] & 1 = 0) AND
        [o].[object_type] = N'target' ;

-- Target Columns
SELECT  [oc].[name] AS column_name,
        [oc].[column_id],
        [oc].[type_name],
        [oc].[capabilities_desc],
        [oc].[description]
FROM    [sys].[dm_xe_packages] AS p
INNER JOIN [sys].[dm_xe_objects] AS o
        ON [p].[guid] = [o].[package_guid]
INNER JOIN [sys].[dm_xe_object_columns] AS oc
        ON [o].[name] = [oc].[object_name] AND
           [o].[package_guid] = [oc].[object_package_guid]
WHERE   ([p].[capabilities] IS NULL OR
         [p].[capabilities] & 1 = 0) AND
        ([o].[capabilities] IS NULL OR
         [o].[capabilities] & 1 = 0) AND
        [o].[object_type] = N'target' AND
        [o].[name] = N'event_file' ;
