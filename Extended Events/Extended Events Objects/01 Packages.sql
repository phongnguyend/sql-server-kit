-- View Extended Event packages
SELECT  *
FROM    [sys].[dm_xe_packages] p
WHERE   ([p].[capabilities] IS NULL OR
         [p].[capabilities] & 1 = 0);

-- View the module that loaded the packages
SELECT  [p].[name] AS [package_name],
        [p].[guid] AS [package_guid],
        [p].[description],
        [olm].[name] AS [module]
FROM    [sys].[dm_xe_packages] AS p
INNER JOIN [sys].[dm_os_loaded_modules] AS olm
        ON [p].[module_address] = [olm].[base_address]
WHERE   ([p].[capabilities] IS NULL OR
         [p].[capabilities] & 1 = 0)
ORDER BY [p].[name] ;
