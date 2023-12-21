#implicit foreach
(Get-ChildItem -Recurse -Exclude *pyro* ../dumb-data/*video.txt).PSPath

#use code block
Get-ChildItem -R ../dumb-data | Where-Object { $_.PSPath -Match "349" } | Select-Object -Property PSPath

#example
Get-ChildItem -R ../dumb-data | Group-Object -Property extension |Sort-Object -Property Count -Descending

#use code block
1..20 | Group-Object -Property { $_ % 2 }

#example
Get-ChildItem | Measure-Object -Property length -Minimum -Maximum -Sum -Average
Get-Content $MyInvocation.MyCommand | Measure-Object -Line

#example
#NOTE :this also turns to a pipe
$pros = Get-Process -Name *note*
Format-Table -InputObject $pros -Property ProcessName, StartTime, PeakPagedMemorySize