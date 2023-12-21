
Split-Path -Path "HKCU:\Software\Microsoft" -Qualifier
# output: HKCU:

Join-Path -Path 'windows' -ChildPath 'Temp'
# output: windows\Temp

Split-Path -Path "./*.ps1" -Leaf -Resolve

Split-Path -Path "C:\WINDOWS\system32\WindowsPowerShell\V1.0\about_*.txt"
# output: C:\WINDOWS\system32\WindowsPowerShell\V1.0

Split-Path -Path ".\My Pictures\*.jpg" -IsAbsolute
# output: False

Set-Location (Split-Path -Path $profile)

"./*" | Resolve-Path
"./[abc]*" | Resolve-Path # wildcard match

