#* var
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_variables?view=powershell-7.4
$a = 5
$b = 6
$a + $b # 11

$a++ | Out-Host # 5,but $a=6

#* operator
#**Ref:
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.2
$a -gt $b #False
$null -ne $a #True

$a = 5, 6, 7, 8, 9
$a.GetType() #type
$a -ge 7 | Out-Host #7,8,9

[DateTime]'2001-11-12' -lt [DateTime]'2020-08-01' # True

"Bag", "Beg", "Big", "Bog", "Bug" -match 'b[iou]g'  #Output: Big, Bog, Bug

$a = 1
$a -is [int]           # Output: True

"def" -in "abc", "def" # True

#* obj, hashtable
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables?view=powershell-7.4
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_objects?view=powershell-7.4
$a_obj = @{
    name = 'yi';
    age = 10
}
$a_obj["<key>"] = "<value>"
$a_obj += @{ enen = 20GB }
$a_obj

$p = @{
    "PowerShell" = (Get-Process pwsh);
}
$p

"Today is $( Get-Date )"

$string = @"
Msg1 = Type "Windows".
Msg2 = She said, "Hello, World."
Msg3 = Enter an alias (or "nickname").
"@
$hash = ConvertFrom-StringData $string
$hash



#* try catch block
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.4
try {
    NonsenseString
    Write-Output "aaaa"
    throw "This is an error."
}
catch {
    Write-Host "An error occurred:"
    Write-Host $_
}

Write-Output "bbbb"

#* pipeline
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

#* invoke
#invoke from string
$Command = "echo ""a b c"""
Invoke-Expression -Command $Command

#invoke from string
&("help")
&("ipconfig")

#* c# object
#create a c# object
[System.Uri]::new("https://www.bing.com")

#* redirect output
#stream 1:log,2:err,3:warn,4:verbose,5:debug,6:info

# > overwrite >> append
# >&1 redirect

Get-ChildItem "./","path/error" > .\dir.log
Get-ChildItem "./","path/error" 2>&1
