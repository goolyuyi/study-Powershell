Get-ChildItem function: # list functions

Get-Command Write-Host | Format-List

$Colors = @{ForegroundColor = "black"; BackgroundColor = "white"}
Write-Host "This is a test." @Colors
Write-Host @Colors "This is another test."

