sqlcmd -S ServerIP -U UserName -P Password -d DBName -i "script-nodate.sql" -o "pub-nodate.txt" -W
sqlcmd -S ServerIP -U UserName -P Password -d DBName -i "script-nodate.sql" -o "sub-nodate.txt" -W
"C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe" -diff sub-nodate.txt pub-nodate.txt
