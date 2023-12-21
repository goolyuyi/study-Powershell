## Useful Commands
### invoke...
* `ii`
* `iex`
* `icm`

### misc
* `sls` Select-String


# Customize PWSH

## PSReadLine
Set the prompt window auto-hint
* `Set-PSReadLineOption -PredictionSource History`
* `Set-PSReadLineOption -PredictionSource None`

## Profile

list all PROFILE path
* `$PROFILE| gm -MemberType NoteProperty`


* [about_PowerShell_Config](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_powershell_config?view=powershell-7.2)
* [about_PSReadLine](https://docs.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline#completion-functions)
* [about_Profiles](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.2)
* [about_Preference_Variables](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables?view=powershell-7.2) -  - Variables that customize the behavior of PowerShell.
    * `$PSModuleAutoLoadingPreference`
* [about_automatic_variables](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables?view=powershell-7.4)


