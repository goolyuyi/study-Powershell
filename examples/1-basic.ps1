#var
$a = 5
$b = 6
$a + $b # 11

$a++ | Out-Host # 5,but $a=6

#operator
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.2
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

#obj, hashtable
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


