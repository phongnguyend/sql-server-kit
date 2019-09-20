sqlcmd -S ServerIP -U UserName -P Password -d DBName -i "script-withdate.sql" -o "pub-withdate.txt" -W
sqlcmd -S ServerIP -U UserName -P Password -d DBName -i "script-withdate.sql" -o "sub-withdate.txt" -W
"C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe" -diff sub-withdate.txt pub-withdate.txt