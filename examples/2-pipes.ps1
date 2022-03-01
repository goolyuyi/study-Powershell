(Get-ChildItem -Recurse -Exclude *pyro* ../dumb-data/*video.txt).PSPath

#Get-ChildItem -R ../dumb-data | Where-Object { $_.PSPath -Match "349" } | Select-Object -Property PSPath

Get-ChildItem -R ../dumb-data | Group-Object -Property extension |Sort-Object -Property Count -Descending

1..20 | Group-Object -Property { $_ % 2 }

Get-ChildItem | Measure-Object -Property length -Minimum -Maximum -Sum -Average

Get-Content $MyInvocation.MyCommand | Measure-Object -Line


#NOTE :this also turns to a pipe
$pros = Get-Process -Name *note*
Format-Table -InputObject $pros -Property ProcessName, StartTime, PeakPagedMemorySize

#NOTE: put bash log as string in pwsh
cat ./4-operators.ps1 | Select-String -Pattern "-String"
