-- Event Information for a running session
SELECT  [s].[name] AS session_name,
        [e].[event_name] AS event_name,
        [e].[event_predicate] AS event_predicate,
        [ea].[action_name] AS action_name
FROM    [sys].[dm_xe_sessions] AS s
INNER JOIN [sys].[dm_xe_session_events] AS e
        ON [s].[address] = [e].[event_session_address]
INNER JOIN [sys].[dm_xe_session_event_actions] AS ea
        ON [e].[event_session_address] = [ea].[event_session_address] AND
           [e].[event_name] = [ea].[event_name] ;

-- Target information for a running session
SELECT  [s].[name] AS session_name,
        [t].[target_name] AS target_name,
        [t].[execution_count] AS execution_count,
        [t].[execution_duration_ms] AS execution_duration,
        CAST([t].[target_data] AS XML) AS target_data
FROM    [sys].[dm_xe_sessions] AS s
INNER JOIN [sys].[dm_xe_session_targets] AS t
        ON [s].[address] = [t].[event_session_address] ;

-- Configurable event and target column information
SELECT DISTINCT
        [s].[name] AS session_name,
        [oc].[object_name],
        [oc].[object_type],
        [oc].[column_name],
        [oc].[column_value]
FROM    [sys].[dm_xe_sessions] AS s
INNER JOIN [sys].[dm_xe_session_targets] AS t
        ON [s].[address] = [t].[event_session_address]
INNER JOIN [sys].[dm_xe_session_events] AS e
        ON [s].[address] = [e].[event_session_address]
INNER JOIN [sys].[dm_xe_session_object_columns] AS oc
        ON [s].[address] = [oc].[event_session_address] AND
           (([oc].[object_type] = N'target' AND
             [t].[target_name] = [oc].[object_name]) OR
            ([oc].[object_type] = N'event' AND
             [e].[event_name] = [oc].[object_name])) ;
