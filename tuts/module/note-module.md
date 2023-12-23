# ref

* [about_Modules](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_modules?view=powershell-7.2)
* [about_Command_Precedence](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_command_precedence?view=powershell-7.2)
* [Writing a Powershell Cmdlet](https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/cmdlet-overview?view=powershell-7.2)
* [Writing a Windows PowerShell Module](https://docs.microsoft.com/en-us/powershell/scripting/developer/module/writing-a-windows-powershell-module?view=powershell-7.2)

## Note

* for local module only need `.psm1`
* for distribute module need `psd1` for meta info
* no matter how, you need to export func/alias/var... in `psm1`
    * use `Export-ModuleMember`

## file ext

* `.ps1` powershell script
* `.psm1` powershell module script
* `.psd1` powershell module metadata

## dot source

*  import with break the scope
* like `source` in bash,

```powershell
. .\Get-MrPSVersion.ps1
```

## detail

* Export: use `Export-ModuleMember` to explicitly export a function/alias/vars in `psm1`

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

```powershell
New-ModuleManifest -Path $env:ProgramFiles\WindowsPowerShell\Modules\MyScriptModule\MyScriptModule.psd1 -RootModule MyScriptModule -Author 'Mike F Robbins' -Description 'MyScriptModule' -CompanyName 'mikefrobbins.com'
```


