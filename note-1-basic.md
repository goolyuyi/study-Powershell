## Help

* `Get-Command`
* `Get-Help`
  * `Update-Help` download the local help docs
  * Mode:
    * `-Full`
    * `-Detailed`
    * `-Examples`
    * `-Online`
    * `-Parameter param-name`
      * `help Get-Help -Parameter Name`
    * `-ShowWindow`
* `Get-Verb` only use the verbs listed here when you write your own script
* `Get-Member`

```powershell
Get-Command -ListImported
Get-Command -Type Cmdlet | Sort-Object -Property Noun | Out-GridView
Get-Command -Module Microsoft.PowerShell.Security, Microsoft.PowerShell.Utility
Get-Command -Verb 'Get'
Get-Command -Noun U*
```

## Ref

* [about_Automatic_Variable](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables)
* [about_Execution_Policies](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies)
* [about_Hash_Tables](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables)
* [about_Operators](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators)
* [about_Object_Creation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_object_creation)
* [about_Pipelines](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pipelines)
* [about_Arrays](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arrays)
* [about_Redirection](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_redirection?view=powershell-7)
* [about_Wildcards](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_wildcards)
* [about_pwsh](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pwsh)

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

* Get-Member
  * `Get-Member -Name MachineName`
  * `Get-Service -Name w32time | Get-Member -MemberType Method`
* Select-Object
  * `Get-Service | Select-Object -Property DisplayName, Running, Status | Where-Object CanPauseAndContinue`
* Where-Object
  * `Get-Service | Where-Object Name -eq w32time`
* Out-String/Out-File/Out-GridView/Format-Table/Format-List/Format-Wide
* `ls Variable:`
* Write-Output/Write-Host/Write-Verbose/Write-Error

## Automatic Variables

You should figure out these auto vars below:

* `$PSVersionTable`
* `$_` same as `$PSItem`
* `$false,$true,$null`
* `$HOME`
* `$args`

## Execution Policies

> 如果设置作用域 LocalMachine 或 CurrentUser 的执行策略，则更改将保存在注册表中并保持有效，直到再次更改。

## Hash Table

* a dict struct / basic object in powershell like a json

```powershell
[<class-name>]@{
<property-name> = <property-value>
<property-name> = <property-value>
}
```

```powershell
$hash = @{ Number = 1; Shape = "Square"; Color = "Blue" }
$hash.Number
$hash["Shape"]
```

```powershell
$string = @"
Msg1 = Type "Windows".
Msg2 = She said, "Hello, World."
Msg3 = Enter an alias (or "nickname").
"@
ConvertFrom-StringData $string
```

## Environment Variables

**env acts like a path via powershell's env provider**

> 若要对应用程序环境变量进行Windows，请使用 System 控制面板。 选择 "高级系统设置" 。 在"高级 "选项卡 上，单击"环境变量..."

`ls Env:`

`$Env:Path += ";c:\temp"`

`Remove-Item -Path Env:Path`

`Set-Item -Path Env:Path -Value ($Env:Path + ";C:\Temp")`

You should figure out these env vars below:

* `$env:PSModulePath`

## Object

* [New-Object](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-object):
* [Import-Csv](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/import-csv) / [ConvertFrom-CSV](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertfrom-csv):
* [ConvertFrom-Json](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertfrom-json):
* [ConvertFrom-StringData](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertfrom-stringdata):
* [Add-Type](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-type): Allows you to define a class in your PowerShell session that you can instantiate with `New-Object`.
* [New-Module](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/new-module): The **AsCustomObject** parameter creates a custom object you define using script block.
* [Add-Member](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-member): Adds properties to existing objects. You can use `Add-Member` to create a custom object out of a simple type, like `[System.Int32]`.
* [Select-Object](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-object): Selects properties on an object. You can use `Select-Object` to create custom and calculated properties on an already instantiated object.

### new()

```powershell
[System.Uri]::new("https://www.bing.com")
```

## Alias

```powershell
Get-Alias -Name gcm
Get-Alias
Get-Alias -Definition Get-Command
ls Alias:
```

## Provider

```powershell
Get-PSProvider
```

* Alias:
* Cert:
* Env:
* C: D:
* Function:
* HKLM: HKCU:
* Variable:
* WSMan:

## Array

```powershell
$A = 22,5,10,8,12,9,80
$B = ,7
$C = 5..8
[int32[]]$ia = 1500,2230,3350,4000
[Diagnostics.Process[]]$zz = Get-Process
$p = @(Get-Process Notepad)
```

## Operator

`()` - Grouping

`$()` - Subexpression

```powershell
"Today is $(Get-Date)"
```

`@()` - array

```powershell
$list = @(Get-Process | Select-Object -First 10; Get-Service | Select-Object -First 10 )
```

`@{}` - hashtable

`&` - call

```powershell
PS> $c = "get-executionpolicy"
PS> $c
get-executionpolicy
PS> & $c
AllSigned
```

`&` - background

```powershell
Get-Process -Name pwsh &
```

`[]` - cast

```powershell
[DateTime] '2/20/88' - [DateTime] '1/20/88' -eq [TimeSpan] '31'
```

`.` - source

```powershell
. c:\scripts\sample.ps1 1 2 -Also:3
```

`-f` - format

```powershell
"{0} {1,-10} {2:N}" -f 1,"hello",[math]::pi
```

`&&` `||` - pipeline chain

`::` - static member

```powershell
[datetime]::Now
'MinValue', 'MaxValue' | Foreach-Object { [int]:: $_ }
```

`??` `??=` `?.` `?[]` - null test

```powershell
$x = $null
$x ?? 100

$a = @{ PropName = 100 }
${a}?.PropName

$a = 1..10
${a}?[0]
```

## Flow Control

```powershell
'ActiveDirectory', 'SQLServer' |
   ForEach-Object {Get-Command -Module $_} |
     Group-Object -Property ModuleName -NoElement |
         Sort-Object -Property Count -Descending
```

```powershell
$ComputerName = 'DC01', 'WEB01'
foreach ($Computer in $ComputerName) {
  Get-ADComputer -Identity $Computer
}
```

```powershell
for ($i = 1; $i -lt 5; $i++) {
  Write-Output "Sleeping for $i seconds"
  Start-Sleep -Seconds $i
}
```

```powershell
$number = Get-Random -Minimum 1 -Maximum 10
do {
  $guess = Read-Host -Prompt "What's your guess?"
  if ($guess -lt $number) {
    Write-Output 'Too low!'
  }
  elseif ($guess -gt $number) {
    Write-Output 'Too high!'
  }
}
until ($guess -eq $number)
```

```powershell
$date = Get-Date -Date 'November 22'
while ($date.DayOfWeek -ne 'Thursday') {
  $date = $date.AddDays(1)
}
Write-Output $date
```

## Invokes

* `Invoke-Command`: run command on local or remote sessions
  * `Invoke-Command -FilePath c:\scripts\test.ps1 -ComputerName Server01`
* `Invoke-Expression`: Runs commands or expressions on the local computer.
  * run anything like exe,script,bash script,ps1...
