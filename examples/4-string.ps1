$env:Path | Out-String | ForEach-Object { $_.split(";") }

'Hello', 'HELLO' | Select-String -Pattern 'HELLO' -CaseSensitive -SimpleMatch

"PS version: $( $PSVersionTable.PSVersion )"

$i = 5
"The value of `$i is $i."
'The value of $i is $i.'

"As they say, ""live and learn."""
"Use a quotation mark (`") to begin a string."

@"
Even if you have not created a profile,
the path of the profile file is:
$profile.
"@


"hashtable: $( @{ key = 'value' } )"

"hashtable:`n$((@{ key = 'value' } | Out-String).Trim() )"

# `n = \n
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_special_characters?view=powershell-7.2

