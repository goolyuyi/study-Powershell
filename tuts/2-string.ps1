#wildcard pattern
"PowerShell" -like "*shell" # Output: True

#regex pattern
"PowerShell" -match '^Power\w+' # Output: True

#regex pattern
"PowerShell" -match '^Power(?=S\w+)' # Output: True

#split
($env:Path | Out-String).split(";")

#substitute
"PS version: $( $PSVersionTable.PSVersion )"

#like grep
'Hello', 'HELLO' | Select-String -Pattern 'HELLO' -CaseSensitive -SimpleMatch

#substitute var
$i = 5
"The value of $i is $i."
"The value of `$i is $i."

#single quote present it raw
'The value of $(2+3) is 5.'

#escape
"As they say, `"live and learn.`""

#multi line literal string
@"
Even if you have not created a profile,
the path of the profile file is:
$profile.
"@

#`n - line break
"hashtable:`n$((@{ key = 'value' } | Out-String).Trim() )"


# format string
$first = @{
    name = 'yu'
    age = 33
}
$last = "k"

'Hello, {0} {1}.' -f $first, $last
"Population {0:N0}" -f  8175133

# array join
@(
'server1'
'server2'
'server3'
) -join ','

# split
"Lastname:FirstName:Address" -split ":"
"Lastname:FirstName:Address" -split "(:)"
"Lastname/:/FirstName/:/Address" -split "/(:)/"
'Chocolate-Vanilla-Strawberry-Blueberry' -split '(-)', 2

# regex match
$string = 'The last logged on user was CONTOSO\jsmith'
$string -match 'was (?<domain>.+)\\(?<user>.+)'

$Matches #last match result

"book" -ireplace "B", "C" # Case insensitive

$SearchExp = '^(?<DomainName>[\w-.]+)\\(?<Username>[\w-.]+)$'
$ReplaceExp = '${Username}@${DomainName}'

'Contoso.local\John.Doe' -replace $SearchExp, $ReplaceExp

