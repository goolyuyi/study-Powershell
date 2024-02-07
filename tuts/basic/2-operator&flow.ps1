#* basic operators
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.2

#* compare
# * Equal to and not equal to: -eq and -ne
# * Like and not like: -like and -notlike
# * Greater than and greater than or equal to: -gt and -ge
# * Less than and less than or equal to: -lt and -le
#
# * all have case-insensitive version: -eq -> -ieq
#
# * on array is a filter


1, $null -ne $null # Returns 1
1, 2, 3, 4 -ge 3 # Returns 3, 4
'one', 'two', 'three' -like '*e*' # Returns one, three

#** Compare-Object
Compare-Object -ReferenceObject 1, 2, 3, 4 -DifferenceObject 1, 2

#Example: find out the same files in two folders
$params = @{
    ReferenceObject = Get-ChildItem C:\Windows\System32 -File
    DifferenceObject = Get-ChildItem C:\Windows\SysWOW64 -File
    Property = 'Name', 'Length'
    IncludeEqual = $true
    ExcludeDifferent = $true
}
Compare-Object @params

#** $null
$null -ne $a #True

#*** Null coalescing ?? ??=
$vB = $vA ?? "kkk"
$vB

#*** depend on ret value
function first
{
}
function second
{
    'second'
}
function third
{
    'third'
}
(first) ?? (second) ?? (third)

#*** ??=
$value = $null
$value ?? = 1
$value ?? = 2
$value

#*** Null conditional
$someOtherObject = [PSCustomObject]@{
Value = $null
}
$someOtherObject.{
Value
}?.ToString()

#** in/contains
#** in/notin
"def" -in "abc", "def" # True
$colors = 'red', 'green', 'blue', 'gray'
'red' -in $colors

#** contains/notcontains
$colors -contains 'blue'

#** logic: -and -or -xor -not/!
# bitwise: -band -bor -bxor -bnot -shl/-shr(shift)

#** type check
(Get-Process | Select-Object -First 1).GetType()

#** type check: as, is, notis
#is: restrictly
$a = 1
$a -is [int] # Output: True
$a -isnot [string] #Output: True

#as: attempt to convert
"1" -as [Int32]
'String' -as [Type]

#============================================================================
#* redirect output
#stream 1:log,2:err,3:warn,4:verbose,5:debug,6:info

# > overwrite >> append
# >&1 redirect
Get-ChildItem "./", "path/error" > .\dir.log
Get-ChildItem "./", "path/error" 2>&1

#* redirect to file
"aaaa" > 'warnings.txt' # Overwrite
"aaaa">> 'warnings.txt' # Append

#============================================================================
#* pipeline chain
function left {
throw 'Wrong'
}
function right {
'Done!'
}
left && right
left || right

#============================================================================
#* invoke/call operator
#invoke from string
$Command = "echo ""a b c"""
Invoke-Expression -Command $Command

#invoke from string
&("help")
&("ipconfig")

#invoke exe
& 'C:\Program Files\PowerShell\7\pwsh.exe'

#invoke + splatting
$pwsh = 'C:\Program Files\PowerShell\7\pwsh.exe'
$argumentList = @(
'-NoProfile'
'-NoLogo'
'-Command'
'Write-Host "Hello world"'
)
& $pwsh $argumentList

#============================================================================
#* background job
$job = Get-Process &
$job | Receive-Job

#============================================================================

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
#============================================================================
#* var modifier
$Global: var = 123

function func{
$Private: var = 123
}


[String](Get-Date)
[DateTime]"01/01/2016"
'01/01/2016' -as [DateTime]
$xml = [Xml]'<root><child /></root>'

$array = foreach ($value in 1..5) {
[PSCustomObject]@{
Value = $value
}
}
$array[0].GetType()

$myArray = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
$myArray[-1]
$myArray[2..4]
$myArray[-1..-4]

switch (Get-Date) {
{
$_ -is [DateTime]
} {
Write-Host 'This is a DateTime type'
}
{
$_.Year -ge 2020
} {
Write-Host 'It is 2020 or later'
}
}

$processes = Get-Process
for ($i = 0; $i -lt $processes.Count; $i++) {
Write-Host $processes[$i].Name
}

Get-Location
Set-Location
Push-Location
Pop-Location
Get-Item
Get-ChildItem
Test-Path
Test-Path C: \Windows -PathType Container
Test-Path C: \Windows\System32\cmd.exe -PathType Leaf
New-Item
Remove-Item
Invoke-Item

$file = Get-Item 'somefile.txt'
$file.Attributes = $file.Attributes -bxor 'ReadOnly'




#=============================================================================================================
#* try catch finnally throw trap
#https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-exceptions?view=powershell-7.4
#If you specify -ErrorAction Stop, Write-Error generates a terminating error that can be handled with a catch.
Write-Error -Message "Houston, we have a problem." -ErrorAction Stop

#If you specify -ErrorAction Stop on any advanced function or cmdlet, \
#it turns all Write-Error statements into terminating errors that stop execution or that can be handled by a catch.
Start-Something -ErrorAction Stop

#You can access the exception information in the catch block using the $_ variable.
try
{
Start-Something -ErrorAction Stop
}
catch
{
Write-Output "Something threw an exception or used Write-Error"
Write-Output $_
}

#Catching typed exceptions
try
{
Start-Something -Path $path -ErrorAction Stop
}
catch [System.IO.DirectoryNotFoundException],[System.IO.FileNotFoundException]
{
Write-Output "The path or file was not found: [$path]"
}
catch [System.IO.IOException]
{
Write-Output "IO error with the file: [$path]"
}

#Throwing typed exceptions
#throw [System.IO.FileNotFoundException] "Could not find: $path"


#TODO : https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scripts?view=powershell-7.4
#TODO : dot source/scope ... try your self

#TODO : doc this
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_outputtypeattribute?view=powershell-7.4

#TODO : learn this
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_commonparameters?view=powershell-7.4

#TODO : learn this
#https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-shouldprocess?view=powershell-7.4

#https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.4
#https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-switch?view=powershell-7.4
#https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-string-substitutions?view=powershell-7.4

#https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-pscustomobject?view=powershell-7.4


# $WhatIfPreference

#$first.BaseName
#$first.Extension

#$first.Name
#$first.Parent

#$first.FullName

#$first.Attributes
