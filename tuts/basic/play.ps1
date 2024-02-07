$b = (Get-Date)
$b

$b = (Get-Date).ToString() + "cccc"
$b

$c = @(1, 2, 3)
$c[2]

Add-Member -Name "tttt" -Value 11111 -InputObject $c -MemberType NoteProperty
$c

$c += @{ 1 = 321 }
$c.GetType()
#$c | Get-Member -MemberType Methods
#$c.GetType()

#"ttttt".Substring

Write-Host "-------------------"
$c = @{ 1 = 1; 2 = 2 }
$c | Add-Member @{ Name = "UUU" }
$c

"tttt" | Get-Member -MemberType Methods

"print `$c {0}" -f $b

"aaaaaaacabc" -like "*[a-c]bc"
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_wildcards?view=powershell-7.4

"aaaabc" -match "[a]{3}abc"

#Get-ChildItem | Select-Object -First 1 | Get-Member -MemberType Property
$t = (Get-ChildItem | Select-Object -First 1)
$t.ToString()
$t.Parent.GetFiles()

$aa = @(1, 2, 3, 4)
foreach ($i in $aa)
{
    "i:{0}" -f $i
}

for ($i = 0; $i -lt 5; $i++){
    "i:{0}" -f $i
}

$i=0
while ($i -lt 5){
    "i:{0}" -f $i
    $i++
}

#Compare-Object
