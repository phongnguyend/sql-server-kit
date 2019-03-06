-- Get events in a session
SELECT  [sese].[package] AS event_package,
        [sese].[name] AS event_name,
        [sese].[predicate] AS event_predicate
FROM    [sys].[server_event_sessions] AS ses
INNER JOIN [sys].[server_event_session_events] AS sese
        ON [ses].[event_session_id] = [sese].[event_session_id]
WHERE   [ses].[name] = N'system_health' ;

-- Get actions 
SELECT  [sese].[package] AS event_package,
        [sese].[name] AS event_name,
        [sese].[predicate] AS event_predicate,
        [sesa].[package] AS action_package,
        [sesa].[name] AS action_name
FROM    [sys].[server_event_sessions] AS ses
INNER JOIN [sys].[server_event_session_events] AS sese
        ON [ses].[event_session_id] = [sese].[event_session_id]
INNER JOIN [sys].[server_event_session_actions] AS sesa
        ON [ses].[event_session_id] = [sesa].[event_session_id] AND
           [sese].[event_id] = [sesa].[event_id]
WHERE   [ses].[name] = N'system_health' ;


-- Get customizable column configuration
SELECT  [ses].[name] AS sesion_name,
        [sese].[package] AS event_package,
        [sese].[name] AS event_name,
        [sese].[predicate] AS event_predicate,
        [sesf].[name] AS customizable_column_name,
        [sesf].[value] AS value
FROM    [sys].[server_event_sessions] AS ses
INNER JOIN [sys].[server_event_session_events] AS sese
        ON [ses].[event_session_id] = [sese].[event_session_id]
INNER JOIN [sys].[server_event_session_fields] AS sesf
        ON [ses].[event_session_id] = [sesf].[event_session_id] AND
           [sese].[event_id] = [sesf].[object_id]
WHERE   [ses].[name] = N'system_health' ;


-- Get target information
SELECT  [ses].[name] AS session_name,
        [sest].[name] AS target_name,
        [sesf].[name] AS option_name,
        [sesf].[value] AS option_value
FROM    [sys].[server_event_sessions] AS ses
INNER JOIN [sys].[server_event_session_targets] AS sest
        ON [ses].[event_session_id] = [sest].[event_session_id]
INNER JOIN [sys].[server_event_session_fields] AS sesf
        ON [sest].[event_session_id] = [sesf].[event_session_id] AND
           [sest].[target_id] = [sesf].[object_id]
WHERE   [ses].[name] = N'system_health' ;
