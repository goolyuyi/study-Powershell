$env:Path | Out-String | ForEach-Object {$_.split(";")}

