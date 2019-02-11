-- Query 12 - Getting the Processor Description

-- Get processor description from Windows Registry  (Query 12) (Processor Description)
EXEC xp_instance_regread N'HKEY_LOCAL_MACHINE', N'HARDWARE\DESCRIPTION\System\CentralProcessor\0', N'ProcessorNameString';

-- Gives you the model number and rated clock speed of your processor(s)
-- Your processors may be running at less than the rated clock speed due
-- to the Windows Power Plan or hardware power management