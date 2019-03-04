
-- Event objects
SELECT  [p].[name] AS package_name,
        [o].[name] AS event_name,
        [o].[description]
FROM    [sys].[dm_xe_packages] AS p
INNER JOIN [sys].[dm_xe_objects] AS o
        ON [p].[guid] = [o].[package_guid]
WHERE   ([p].[capabilities] IS NULL OR
         [p].[capabilities] & 1 = 0) AND
        ([o].[capabilities] IS NULL OR
         [o].[capabilities] & 1 = 0) AND
        [o].[object_type] = N'event' ;

-- Event Columns
SELECT  [oc].[name] AS column_name,
        [oc].[column_type] AS column_type,
        [oc].[column_value] AS column_value,
        [oc].[description] AS column_description
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
        ([oc].[capabilities] IS NULL OR
         [oc].[capabilities] & 1 = 0) AND
        [o].[object_type] = N'event' AND
        [o].[name] = N'wait_info' ;

-- Look at available customizable columns
SELECT  [o].[name] AS event_name,
        [oc].[name] AS column_name,
        [oc].[column_value],
        [oc].[description]
FROM    [sys].[dm_xe_packages] AS p
INNER JOIN [sys].[dm_xe_objects] AS o
        ON [p].[guid] = [o].[package_guid]
INNER JOIN [sys].[dm_xe_object_columns] AS oc
        ON [o].[package_guid] = [oc].[object_package_guid] AND
           [o].[name] = [oc].[object_name]
WHERE   ([p].[capabilities] IS NULL OR
         [p].[capabilities] & 1 = 0) AND
        ([o].[capabilities] IS NULL OR
         [o].[capabilities] & 1 = 0) AND
        ([oc].[capabilities] IS NULL OR
         [oc].[capabilities] & 1 = 0) AND
        [o].[object_type] = N'event' AND
        [oc].[column_type] = N'customizable' ;

