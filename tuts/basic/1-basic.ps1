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
try
{
    NonsenseString
    Write-Output "aaaa"
    throw "This is an error."
}
catch
{
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

Get-ChildItem "./", "path/error" > .\dir.log
Get-ChildItem "./", "path/error" 2>&1


#* Providers
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-7.4

# * Alias: PowerShell aliases
# * Environment: Environment variables (for the process)
# * FileSystem: Files and folders
# * Function: Any functions in the session
# * Variable: Any variables in the session

# only in Windows:
# * Registry: All loaded registry hives
# * Certificate: The LocalMachine and CurrentUser certificate stores
# * WSMan: Windows remoting configuration

#** List all Providers
Get-PSDrive
Get-PSProvider
#Output:
#Name     Used (GB) Free (GB) Provider       Root
#----     --------- --------- --------       ----
#Alias                        Alias
#C            89.13    111.64 FileSystem     C:\
#Cert                         Certificate    \
#D             0.45     21.86 FileSystem     D:\
#Env                          Environment
#Function                     Function
#HKCU                         Registry       HKEY_CURRENT_USER
#HKLM                         Registry       HKEY_LOCAL_MACHINE
#Variable                     Variable
#WSMan                        WSMan
#

#** list all functions
Get-ChildItem function: # list functions


#* Argument mode vs Expression mode
#compare these two
Set-Content -Path commands.txt -Value 'Get-ChildItem', 'Get-Item'
Get-Command -Name Get-Content commands.txt
#VS
Set-Content -Path commands.txt -Value 'Get-ChildItem', 'Get-Item'
Get-Command -Name (Get-Content commands.txt)


#* Query pwsh info
#Get-PSBreakpoint            Get-PSProvider              Get-PSResource              Get-PSSessionCapability
#Get-PSCallStack             Get-PSReadLineKeyHandler    Get-PSResourceRepository    Get-PSSessionConfiguration
#Get-PSDrive                 Get-PSReadLineOption        Get-PSScriptFileInfo
#Get-PSHostProcessInfo       Get-PSRepository            Get-PSSession

#* Output level
# Write-Output 1
# Write-Error 2
# Write-Warning 3
# Write-Verbose 4
# Write-Debug 5
# Write-Information 6

#* Object
$process = Get-Process -Id $PID
$process.Name

#** get method desc
'thisString'.Substring

#*** add member
empty = New-Object Object
$empty | Add-Member -NotePropertyName New -NotePropertyValue 'Hello world'
$params = @{
    Name = 'Replace'
    MemberType = 'ScriptMethod'
    Value = { $this.New -replace 'world', 'everyone' }
}
$empty | Add-Member @params

#** property set
Get-Process -Id $PID | Get-Member -MemberType PropertySet

#* code
Get-Process | ForEach-Object {
    Write-Host $_.Name -ForegroundColor Green
}

#** parallel
$string = 'Hello world'
1 | ForEach-Object -Parallel {
    # The $string variable is only accessible if using is used.
    $using:string
}

#* where
Get-Process | Where-Object -Property StartTime -Value (Get-Date 9:00:00) -gt

#* select
Get-Process | Select-Object -Property Name, *Memory
Get-ChildItem C:\ -Recurse | Select-Object -First 2
Get-ChildItem C:\ | Select-Object -Skip 4 -First 1
Get-ChildItem C:\ | Select-Object -Index 3, 4, 5

#** programmatic select
Get-Process | Select-Object @{ Name = 'ProcessID'; Expression = 'ID' }
Get-Process | Select-Object @{ Name = 'ProcessID'; Expression = { $_.ID } }

#** with ExpandProperty
Get-Process | Select-Object -First 5 -ExpandProperty Name
# vs raw
Get-ChildItem $env:SYSTEMROOT\*.dll |Select-Object -Property VersionInfo -First 1|Format-List *
Get-ChildItem $env:SYSTEMROOT\*.dll |Select-Object -Property FullName, Length -ExpandProperty VersionInfo |Format-List *

#** with Unique
1, 1, 1, 3, 5, 2, 2, 4 | Select-Object -Unique
# same as
1, 1, 1, 3, 5, 2, 2, 4 | Sort-Object | Get-Unique


#* get type
(Get-Process | Select-Object -First 1).GetType()

#* group
6, 7, 7, 8, 8, 8 | Group-Object -NoElement

# two lvl group, think it has series of level
Get-ChildItem C:\Windows\Assembly -Filter *.dll -Recurse |
        Group-Object Name, Length -NoElement |
        Where-Object Count -gt 1 |
        Sort-Object Name -Descending |
        Select-Object Name, Count -First 5

#group email
'one@one.example', 'two@one.example', 'three@two.example' |
        Group-Object { ($_ -split '@')[1] }

#** as hashtable
$hashtable = @(
    [IPAddress]'10.0.0.1'
    [IPAddress]'10.0.0.2'
    [IPAddress]'10.0.0.1'
) | Group-Object -AsHashtable -AsString
$hashtable['10.0.0.1']


#* measure
1, 5, 9, 79 | Measure-Object -Average -Maximum -Minimum -Sum

Get-Process | Measure-Object WorkingSet -Average

#* compare
Compare-Object -ReferenceObject 1, 2, 3, 4 -DifferenceObject 1, 2

# find out the same files in two folders
$params = @{
    ReferenceObject = Get-ChildItem C:\Windows\System32 -File
    DifferenceObject = Get-ChildItem C:\Windows\SysWOW64 -File
    Property = 'Name', 'Length'
    IncludeEqual = $true
    ExcludeDifferent = $true
}
Compare-Object @params