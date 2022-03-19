"PowerShell" -like "*shell"             # Output: True
"PowerShell" -match '^Power\w+'         # Output: True

$env:Path | Out-String | ForEach-Object { $_.split(";") }

'Hello', 'HELLO' | Select-String -Pattern 'HELLO' -CaseSensitive -SimpleMatch

$i = 5
"The value of $i is $i."
"The value of `$i is $i."

'The value of $(2+3) is 5.'

"As they say, `"live and learn.`""


@"
Even if you have not created a profile,
the path of the profile file is:
$profile.
"@

"hashtable:`n$((@{ key = 'value' } | Out-String).Trim() )"

$first = @{
    name = 'yu'
    age = 33
}
$last = "k"
'Hello, {0} {1}.' -f $first, $last


"Population {0:N0}" -f  8175133

@(
'server1'
'server2'
'server3'
) -join ','

"Lastname:FirstName:Address" -split ":"
"Lastname:FirstName:Address" -split "(:)"
"Lastname/:/FirstName/:/Address" -split "/(:)/"
'Chocolate-Vanilla-Strawberry-Blueberry' -split '(-)', 2

"PowerShell" -match '^Power\w+' # Output: True
"PowerShell" -like "*shell"

$string = 'The last logged on user was CONTOSO\jsmith'
$string -match 'was (?<domain>.+)\\(?<user>.+)'

$Matches

"book" -ireplace "B", "C" # Case insensitive

$SearchExp = '^(?<DomainName>[\w-.]+)\\(?<Username>[\w-.]+)$'
$ReplaceExp = '${Username}@${DomainName}'

'Contoso.local\John.Doe' -replace $SearchExp, $ReplaceExp
