Split-Path -Path "HKCU:\Software\Microsoft" -Qualifier

Join-Path -Path 'windows' -ChildPath 'Temp'

Split-Path -Path "./*.ps1" -Leaf -Resolve

Split-Path -Path "C:\WINDOWS\system32\WindowsPowerShell\V1.0\about_*.txt"

Split-Path -Path ".\My Pictures\*.jpg" -IsAbsolute

Set-Location (Split-Path -Path $profile)
