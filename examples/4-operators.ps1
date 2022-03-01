$env:Path | Out-String | ForEach-Object {$_.split(";")}

'Hello', 'HELLO' | Select-String -Pattern 'HELLO' -CaseSensitive -SimpleMatch
