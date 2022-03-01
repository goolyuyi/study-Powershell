## Functions

* [about_Functions](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.2)
* [Approved Verbs](https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.2)
  * include verb alias
  * `Get-Verb`
* [about_Splatting](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting?view=powershell-7.2)
  * `$PSBoundParameters`/`$Args`
* Advanced:
  * [about_Functions_CmdletBindingAttribute](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute?view=powershell-7.2)
  * [about_Functions_Advanced_Parameters](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7.2)
    * [Parameter and variable validation attributes](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_argument_completion?view=powershell-7.2#argumentcompletions-attribute)
    * [about_Functions_Argument_Completion](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_argument_completion?view=powershell-7.2#argumentcompletions-attribute)
  * [about_Functions_Advanced_Methods](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_methods?view=powershell-7.2)
* [about_CommonParameters](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_commonparameters?view=powershell-7.2)
* [about_Comment_Based_Help](https://docs.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.2)
* [about_Scopes](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes?view=powershell-7.2)

### Basic

```powershell
function [<scope:>]<name>
{
  param([type]$parameter1 [,[type]$parameter2]) 
  dynamicparam {<statement list>} 
  begin {<statement list>}
  process {<statement list>}
  end {<statement list>}
}
```

```powershell
function Get-SmallFiles {
  param (
      [PSDefaultValue(Help = '100')] #https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.psdefaultvalueattribute
      $Size = 100
      [switch]$on 
  )
  
  $name = $args[0] + ".txt" # position arg
  $name
}
```

```powershell
function Get-MyCommand { Get-Command @Args } #Splatting: pass all args to Get-Command
```

```powershell
function <name> {
  begin {<statement list>} #run once
  process {<statement list>} # use $_
  end {<statement list>} # run once
}
```

```powershell
filter Get-ErrorLog ([switch]$message) #filter function(useful in pipeline)
{
  if ($message) { Out-Host -InputObject $_.Message }
  else { $_ }
}
```

```powershell
(Get-ChildItem function:help).Definition
```

### Advance

```powershell
function Send-Greeting
{
    [CmdletBinding()] #make this function to advance 
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Name
    )

    Process
    {
        Write-Host ("Hello " + $Name + "!")
    }
}
```

> The `CmdletBinding` attribute is an attribute of functions that makes them operate like compiled cmdlets written in C#. It provides access to the features of cmdlets.

#### Advance Param

* switch: `Param([switch]$AsByteArray)`
* dynamic:

```powershell
function Get-Sample {
  [CmdletBinding()]
  Param([string]$Name, [string]$Path)

  DynamicParam
  {
    if ($Path.StartsWith("HKLM:"))
    {
      $parameterAttribute = [System.Management.Automation.ParameterAttribute]@{
          ParameterSetName = "ByRegistryPath"
          Mandatory = $false
      }

      $attributeCollection = [System.Collections.ObjectModel.Collection[System.Attribute]]::new()
      $attributeCollection.Add($parameterAttribute)

      $dynParam1 = [System.Management.Automation.RuntimeDefinedParameter]::new(
        'KeyCount', [Int32], $attributeCollection
      )

      $paramDictionary = [System.Management.Automation.RuntimeDefinedParameterDictionary]::new()
      $paramDictionary.Add('KeyCount', $dynParam1)
      return $paramDictionary
    }
  }
}
```

* parameter attribute:

```powershell
Param(
    [Parameter(Mandatory=$true,
    ValueFromPipeline=$true)]
    [string[]]
    $ComputerName
)
```

* param alias: `[Alias()]`
* wildcard: `SupportsWildcards ()`
* Argument completion
* Parameter and variable validation

#### Try Catch

```powershell
try {
   $wc = new-object System.Net.WebClient
   $wc.DownloadFile("http://www.contoso.com/MyDoc.doc","c:\temp\MyDoc.doc")
}
catch [System.Net.WebException],[System.IO.IOException] {
    "Unable to download MyDoc.doc from http://www.contoso.com."
}
catch {
    "An error occurred that could not be resolved."
}
```
