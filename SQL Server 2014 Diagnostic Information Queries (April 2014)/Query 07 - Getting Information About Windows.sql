-- Query 7 - Getting Information About Windows 

-- Windows information (SQL Server 2014)  (Query 7) (Windows Info)
SELECT windows_release, windows_service_pack_level, 
       windows_sku, os_language_version
FROM sys.dm_os_windows_info WITH (NOLOCK) OPTION (RECOMPILE);

-- Gives you major OS version, Service Pack, Edition, and language info for the operating system
-- 6.3 is either Windows 8.1 or Windows Server 2012 R2 
-- 6.2 is either Windows 8 or Windows Server 2012
-- 6.1 is either Windows 7 or Windows Server 2008 R2
-- 6.0 is either Windows Vista or Windows Server 2008

-- Windows SKU codes
-- 4  is Enterprise Edition
-- 48 is Professional Edition

-- 1033 for os_language_version is US-English

-- Using SQL Server in Windows 8, Windows 8.1, Windows Server 2012 and Windows Server 2012 R2 environments
-- http://support.microsoft.com/kb/2681562