ECHO OFF

:: Param 1 ist die Url, for example  "http://ddv009.arcplan.com/arcplan/buttonPerformance.html"

SET URL=%1
IF NOT DEFINED URL exit /b 1

PATH=%PATH%;..\..\..\..\..\shared\casperjs\phantomJS\
PATH=%PATH%;..\..\..\..\..\shared\casperjs\batchbin\

call casperjs.bat buttonPerformanceTest.casper.js %URL%

exit /b 0
