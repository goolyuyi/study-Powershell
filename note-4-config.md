## Ref
* [about_PSReadLine](https://docs.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline#completion-functions)
* [about_Profiles](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.2)
  * reuse cross session
* [about_Preference_Variables](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables?view=powershell-7.2)
  * powershell preference
  * `$PSModuleAutoLoadingPreference`

## Profile
| Description                | Path                                                                                                                                                                                                             |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| All Users, All Hosts       | Windows - $PSHOME\Profile.ps1<br/>Linux - /usr/local/microsoft/powershell/7/profile.ps1<br/>macOS - /usr/local/microsoft/powershell/7/profile.ps1                                                                |
| All Users, Current Host    | Windows - $PSHOME\Microsoft.PowerShell_profile.ps1<br/>Linux - /usr/local/microsoft/powershell/7/Microsoft.Powershell_profile.ps1<br/>macOS - /usr/local/microsoft/powershell/7/Microsoft.Powershell_profile.ps1 |
| Current User, All Hosts    | Windows - $Home\[My ]Documents\PowerShell\Profile.ps1<br/>Linux - ~/.config/powershell/profile.ps1<br/>macOS - ~/.config/powershell/profile.ps1                                                                  |
| Current user, Current Host | Windows - $Home\[My ]Documents\PowerShell\Microsoft.PowerShell_profile.ps1<br/>Linux - ~/.config/powershell/Microsoft.Powershell_profile.ps1<br/>macOS - ~/.config/powershell/Microsoft.Powershell_profile.ps1   |

* `$PROFILE` The `$PROFILE` automatic variable stores the paths to the PowerShell profiles that are available in the current session.
  * `$PROFILE | Get-Member -Type NoteProperty`