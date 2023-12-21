## Ref
* [about_Execution_Policies](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies)
* [about_Hash_Tables](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables)
* [about_Operators](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators)
* [about_Object_Creation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_object_creation)
* [about_Pipelines](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pipelines)
* [about_Arrays](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arrays)
* [about_Redirection](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_redirection?view=powershell-7)
* [about_Wildcards](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_wildcards)
* [about_pwsh](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pwsh)
* [about_Output_Streams](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_output_streams?view=powershell-7.2)
* [about_Parsing](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_parsing?view=powershell-7.2)
* [about_Special_Characters](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_special_characters?view=powershell-7.2)

## Help

### Get-Help

* `Update-Help` download the local help docs
* Mode:
    * `-Full`
    * `-Detailed`
    * `-Examples`
    * `-Online`
    * `-Parameter param-name`
        * `help Get-Help -Parameter Name`
    * `-ShowWindow`

### Get-Command

```powershell
Get-Command -ListImported
Get-Command -Type Cmdlet | Sort-Object -Property Noun | Out-GridView
Get-Command -Module Microsoft.PowerShell.Security, Microsoft.PowerShell.Utility
Get-Command -Verb 'Get'
Get-Command -Noun U*
```

## Basic

### Useful Verb

* Sort `Sort-Object`
* Out
* Format
* Select `Select-String` / `Select-Object`
* Tee `Tee-Object`

### Useful Noun

* Content
* Object
* Member
* ChildItem
* String
* Location
* ItemProperty
* Random `Get-Random`
* PSProvider
* PSDrive
* Alias
* Date

### Essential Command

* `Get-Member`
* `Select-Object`

```powershell
Get-Service | Select-Object -Property DisplayName, Running, Status
| Where-Object CanPauseAndContinue
```

* `Where-Object`

```powershell
Get-Service | Where-Object Name -eq w32time
```

* Outputs
    * `Out-String`
    * `Out-File`
    * `Out-GridView`
    * `Out-Null`
    * `Format-Table`
    * `Format-List`
    * `Format-Wide`

* `ls Variable:`

* Writes
    * `Write-Output`
    * `Write-Host`
    * `Write-Verbose`
    * `Write-Error`

## Automatic Variables

* `$PSVersionTable`
* `$_` same as `$PSItem`
* `$false,$true,$null`
* `$HOME`
* `$args`
* `$PSBoundParameters`
* `$?` last exit code
* `$args` command line arguments
* `$Error`
* `$Host`
* `$Matches`
* `$MyInvocation`
* `$PROFILE`

## Execution Policies

> 如果设置作用域 LocalMachine 或 CurrentUser 的执行策略，则更改将保存在注册表中并保持有效，直到再次更改。

## Environment Variables

**env acts like a path via powershell's env provider**

> 若要对应用程序环境变量进行Windows，请使用 System 控制面板。 选择 "高级系统设置" 。 在"高级 "选项卡 上，单击"环境变量..."

```powershell
ls Env:

$Env:Path += ";c:\temp"

Remove-Item -Path Env:Path

Set-Item -Path Env:Path -Value ($Env:Path + ";C:\Temp")
```

## Object

* [New-Object](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-object):
* [Import-Csv](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/import-csv)
  / [ConvertFrom-CSV](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertfrom-csv):
* [ConvertFrom-Json](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertfrom-json):
* [ConvertFrom-StringData](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertfrom-stringdata):
* [Add-Type](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-type): Allows you to
  define a class in your PowerShell session that you can instantiate with `New-Object`.
* [New-Module](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/new-module): The **
  AsCustomObject** parameter creates a custom object you define using script block.

## Invokes

* `Invoke-Command`: run command on local or remote sessions
    * `Invoke-Command -FilePath c:\scripts\test.ps1 -ComputerName Server01`
* `Invoke-Expression`: Runs commands or expressions on the local computer.
    * run anything like exe,script,bash script,ps1...

## Functions

* [about_Functions](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.2)
* [Approved Verbs](https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.2)
    * `Get-Verb`
* [about_Splatting](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting?view=powershell-7.2)
* Advanced:
    * [about_Functions_CmdletBindingAttribute](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute?view=powershell-7.2)
    * [about_Functions_Advanced_Parameters](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7.2)
        * [Parameter and variable validation attributes](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_argument_completion?view=powershell-7.2#argumentcompletions-attribute)
    * [about_Functions_Advanced_Methods](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_methods?view=powershell-7.2)
* [about_Functions_Argument_Completion](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_argument_completion?view=powershell-7.2#argumentcompletions-attribute)
* [about_CommonParameters](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_commonparameters?view=powershell-7.2)
* [about_Comment_Based_Help](https://docs.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.2)
* [about_Scopes](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes?view=powershell-7.2)
    * `global:`
    * `local:`
    * `private:`
    * `script:`
    * `using:`
* [about_Requires](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_requires?view=powershell-7.2)

