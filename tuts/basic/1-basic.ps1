#* var & object
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_variables?view=powershell-7.4
$a = 5
$b = 6
$a + $b # 11

$a++ | Out-Host # 5,but $a=6

$process = Get-Process -Id $PID
$process.Name

#** obj, hashtable
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

#** convert hashtable
"Today is $( Get-Date )"

$string = @"
Msg1 = Type "Windows".
Msg2 = She said, "Hello, World."
Msg3 = Enter an alias (or "nickname").
"@
$hash = ConvertFrom-StringData $string
$hash

$hashtable = @(
    [IPAddress]'10.0.0.1'
    [IPAddress]'10.0.0.2'
    [IPAddress]'10.0.0.1'
) | Group-Object -AsHashtable -AsString
$hashtable['10.0.0.1']

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

#** c# object
#create a c# object
[System.Uri]::new("https://www.bing.com")

#** join array
# same result: 1,2,3,4
@(1, 2) + @(3, 4)
(1, 2) + (3, 4)
1, 2 + 3, 4

#** join hashtable
@{
    key1 = 1
} + @{
    key2 = 2
}

#** tenary
$value = 1
($value -eq 2) ? 'two': 'other number'

#* string
#** substitute
"PS version: $( $PSVersionTable.PSVersion )"

$i = 5
"The value of $i is $i."
"The value of `$i is $i."

#** avoid substitue
'The value of $(2+3) is 5.'

#** escape for: ",\n
"As they say, `"live and learn.`""
"hashtable:`n$((@{
key = 'value'
} | Out-String).Trim() )"

#** multi line literal string
@"
Even if you have not created a profile,
the path of the profile file is:
$profile.
"@

#** format string
$first = @{
name = 'yu'
age = 33
}
$last = "k"
'Hello, {
0
} {
1
}.' -f $first, $last
"Population {0:N0}" -f 8175133

#** like: use */?
'afternoon' -like '*noo?'
"good afternoon" -ilike "*after*"

#** split,match,notmatch,replace use regex!

#** match/notmatch

#pwsh's spec regex '+': one or more spaces
'The cow' -match 'The +cow' # Returns true

#use $Matches to get match result
'1234567689' -match '[0-4]*' # Output:True
$Matches # Output:1234

$string = 'The last logged on user was CONTOSO\jsmith'
$string -match 'was (?<domain>.+)\\(?<user>.+)'

#** split
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_split?view=powershell-7.4
'a1b2c3d4' -split '[0-9]' #only -split is regex, String.Split is not!
$first, $second, $null = '1, 2, 3, 4, 5' -split ', ' # 3,4,5 discard

"Lastname:FirstName:Address" -split ":"
"Lastname:FirstName:Address" -split "(:)"
"Lastname/:/FirstName/:/Address" -split "/(:)/"
'Chocolate-Vanilla-Strawberry-Blueberry' -split '(-)', 2

#** replace
$SearchExp = '^(?<DomainName>[\w-.]+)\\(?<Username>[\w-.]+)$'
$ReplaceExp = '${Username }@${DomainName }'
"Contoso.local\John.Doe" -replace $SearchExp, $ReplaceExp

'abababab' -replace 'a', 'c #Output:cbcbcbcb'

#* pipeline
(Get-ChildItem -Recurse -Exclude *pyro* ../dumb-data/*video.txt).PSPath

#use code block
Get-ChildItem -R ../dumb-data | Where-Object {
$_.PSPath -Match "349"
} | Select-Object -Property PSPath

Get-ChildItem -R ../dumb-data | Group-Object -Property extension |Sort-Object -Property Count -Descending

1..20 | Group-Object -Property {
$_ % 2
}

Get-ChildItem | Measure-Object -Property length -Minimum -Maximum -Sum -Average
Get-Content $MyInvocation.MyCommand | Measure-Object -Line

#NOTE :this also turns to a pipe
$pros = Get-Process -Name *note*
Format-Table -InputObject $pros -Property ProcessName, StartTime, PeakPagedMemorySize

#** measure
1, 5, 9, 79 | Measure-Object -Average -Maximum -Minimum -Sum
Get-Process | Measure-Object WorkingSet -Average

#** codeblock
Get-Process | ForEach-Object {
Write-Host $_.Name -ForegroundColor Green
}

#** parallel
$string = 'Hello world'
1 | ForEach-Object -Parallel {
# The $string variable is only accessible if using is used.
$using: string
}

#** where
Get-Process | Where-Object -Property StartTime -Value (Get-Date 9: 00: 00) -gt

#** select
Get-Process | Select-Object -Property Name, *Memory
Get-ChildItem C: \ -Recurse | Select-Object -First 2
Get-ChildItem C: \ | Select-Object -Skip 4 -First 1
Get-ChildItem C: \ | Select-Object -Index 3, 4, 5

#** programmatic select
Get-Process | Select-Object @{
Name = 'ProcessID'; Expression = 'ID'
}
Get-Process | Select-Object @{
Name = 'ProcessID'; Expression = {
$_.ID
}
}

#** with ExpandProperty
Get-Process | Select-Object -First 5 -ExpandProperty Name
# vs raw
Get-ChildItem $env: SYSTEMROOT\*.dll |Select-Object -Property VersionInfo -First 1|Format-List *
Get-ChildItem $env: SYSTEMROOT\*.dll |Select-Object -Property FullName, Length -ExpandProperty VersionInfo |Format-List *

#** select-string: like grep
'Hello', 'HELLO' | Select-String -Pattern 'HELLO' -CaseSensitive -SimpleMatch

#** with Unique
1, 1, 1, 3, 5, 2, 2, 4 | Select-Object -Unique


#** group
6, 7, 7, 8, 8, 8 | Group-Object -NoElement

# two lvl group, think it has series of level
Get-ChildItem C: \Windows\Assembly -Filter *.dll -Recurse |
Group-Object Name, Length -NoElement |
Where-Object Count -gt 1 |
Sort-Object Name -Descending |
Select-Object Name, Count -First 5

#group email
'one@one.example', 'two@one.example', 'three@two.example' |
Group-Object {
($_ -split '@')[1]
}

# same as
1, 1, 1, 3, 5, 2, 2, 4 | Sort-Object | Get-Unique

#** variable to receive foreach res
$services = Get-CimInstance Win32_Service -Filter 'State = "Running"'
$serviceInfo = foreach ($service in $services)
{
$process = Get-Process -ID $service.ProcessID
[PSCustomObject]@{
Name = $service.Name
ProcessName = $process.Name
ProcessID = $service.ProcessID
Path = $process.Path
MemoryUsed = $process.WorkingSet64 / 1MB
}
}

#* Argument mode vs Expression mode
#compare these two
Set-Content -Path commands.txt -Value 'Get-ChildItem', 'Get-Item'
Get-Command -Name Get-Content commands.txt
#VS
Set-Content -Path commands.txt -Value 'Get-ChildItem', 'Get-Item'
Get-Command -Name (Get-Content commands.txt)



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

[DateTime]'2001-11-12' -lt [DateTime]'2020-08-01' # True

"Bag", "Beg", "Big", "Bog", "Bug" -match 'b[iou]g'  #Output: Big, Bog, Bug