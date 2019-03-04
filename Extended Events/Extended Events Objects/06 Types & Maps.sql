
-- Types
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
        [o].[object_type] = N'type' ;

-- Maps
SELECT  [p].[name] AS package_name,
        [o].[name] AS action_name,
        [o].[description]
FROM    [sys].[dm_xe_packages] AS p
INNER JOIN [sys].[dm_xe_objects] AS o
        ON [p].[guid] = [o].[package_guid]
WHERE   ([p].[capabilities] IS NULL OR
         [p].[capabilities] & 1 = 0) AND
        ([o].[capabilities] IS NULL OR
         [o].[capabilities] & 1 = 0) AND
        [o].[object_type] = N'map' ;
        
-- Show mapped columns
SELECT  [oc].[name] AS column_name,
        [oc].[type_name] AS [type_name],
        [o2].[object_type] AS [object_type]
FROM    [sys].[dm_xe_packages] AS p
INNER JOIN [sys].[dm_xe_objects] AS o
        ON [p].[guid] = [o].[package_guid]
INNER JOIN [sys].[dm_xe_object_columns] AS oc
        ON [o].[name] = [oc].[object_name] AND
           [o].[package_guid] = [oc].[object_package_guid]
INNER JOIN [sys].[dm_xe_objects] AS o2
        ON [oc].[type_name] = [o2].[name] AND
           [oc].[type_package_guid] = [o2].[package_guid] AND
           [o2].[object_type] IN ('map', 'type')
WHERE   ([p].[capabilities] IS NULL OR
         [p].[capabilities] & 1 = 0) AND
        ([o].[capabilities] IS NULL OR
         [o].[capabilities] & 1 = 0) AND
        ([oc].[capabilities] IS NULL OR
         [oc].[capabilities] & 1 = 0) AND
        [o].[object_type] = N'event' AND
        [o].[name] = N'wait_info' AND
        [oc].[column_type] = N'data' ;

-- Map Values
SELECT  [mv].[name],
        [mv].[map_key],
        [mv].[map_value]
FROM    [sys].[dm_xe_map_values] AS mv
WHERE   [mv].[name] = N'wait_types' ;
