# ref
[about_Modules](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_modules?view=powershell-7.2)
[about_Command_Precedence](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_command_precedence?view=powershell-7.2)

## file ext

* `.ps1` powershell script
* `.psm1` powershell module script
* `.psd1` powershell module metadata

## dot source

* like `source` in bash

```powershell
. .\Get-MrPSVersion.ps1
```

## module

* module path:

```powershell
$env:PSModulePath -split ';'
```

* Export: use Export-ModuleMember to explicitly export a function in `psm1`, otherwise all function will be exported in
  a `psm1`

```powershell
Export-ModuleMember -Function Get-MrPSVersion
```

* set preference `$PSModuleAutoLoadingPreference`

```powershell
Get-Module
Get-Module -ListAvailable
Import-Module NetTCPIP
Get-Command -Module NetTCPIP
```

* create module manifest
    * in manifest, you also can explicitly export function, like `Export-ModuleMember`

```powershell
New-ModuleManifest -Path $env:ProgramFiles\WindowsPowerShell\Modules\MyScriptModule\MyScriptModule.psd1 -RootModule MyScriptModule -Author 'Mike F Robbins' -Description 'MyScriptModule' -CompanyName 'mikefrobbins.com'
```