#* operators
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.2

#* compare
# * Equal to and not equal to: -eq and -ne
# * Like and not like: -like and -notlike
# * Greater than and greater than or equal to: -gt and -ge
# * Less than and less than or equal to: -lt and -le

# * all have case-insensitive version: -eq -> -ieq

# * on array is a filter
1, $null -ne $null # Returns 1
1, 2, 3, 4 -ge 3 # Returns 3, 4
'one', 'two', 'three' -like '*e*' # Returns one, three

#** Compare-Object
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

#** $null
$null -ne $a #True

#* in/contains
# in/notin
"def" -in "abc", "def" # True
$colors = 'red', 'green', 'blue', 'gray'
'red' -in $colors

# contains/notcontains
$colors -contains 'blue'

#* logic: -and -or -xor -not/!
# bitwise: -band -bor -bxor -bnot -shl/-shr(shift)

#* type check

#** get type
(Get-Process | Select-Object -First 1).GetType()

#** type check: as, is, notis
#is: restrictly
$a = 1
$a -is [int] # Output: True
$a -isnot [string] #Output: True

#as: attempt to convert
"1" -as [Int32]
'String' -as [Type]


#* redirect output
#stream 1:log,2:err,3:warn,4:verbose,5:debug,6:info

# > overwrite >> append
# >&1 redirect

Get-ChildItem "./", "path/error" > .\dir.log
Get-ChildItem "./", "path/error" 2>&1


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

#* redirect to file
"aaaa" > 'warnings.txt' # Overwrite
"aaaa">> 'warnings.txt' # Append



