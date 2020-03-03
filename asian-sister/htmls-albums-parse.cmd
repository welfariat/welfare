@echo off
for /r %%i in (htmls\albums\view_*.html) do (
	FOR /F "tokens=* USEBACKQ" %%D IN (`echo %%i ^| sed "s/.*\\view_//g;s/_.*//g"`) DO SET DIR=%%D
	echo site\%DIR% > site\%DIR%\README.md
	egrep -o "<h1.*>.*</h1>" %%i | sed "s/<[^>]\+>//g;s/^/# /g" > site\%DIR%\README.md
	echo >> site\%DIR%\README.md
	egrep -o "<h2 style='font-size:16px;font-weight:normal;'>.*</h2>" %%i | sed "s/<[^>]\+>//g;s/^/> /g" >> site\%DIR%\README.md
	echo >> site\%DIR%\README.md
	egrep -o "<div class='tegItem'>[^<>]+</div>" %%i | sed "s/<[^>]\+>/`/g" >> site\%DIR%\README.md
)