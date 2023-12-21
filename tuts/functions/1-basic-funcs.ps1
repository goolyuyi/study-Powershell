#* Ref:
#about_function:
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.4

#about_Functions_Advanced_Parameters
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7.4


function Get-PowerShellProcess
{
    Get-Process pwsh
}

Get-PowerShellProcess

"##############################"

#* Syntax:
#   function [<scope:>]<name>
#   {
#   param([type]$parameter1 [,[type]$parameter2])
#   dynamicparam {<statement list>} #should return a hashtable
#   begin {<statement list>}
#   process {<statement list>}
#   end {<statement list>} # end is DEFAULT
#   }

#* Convinience:
#use verb-noun as name

function Add-Numbers([int]$one, [int]$two)
{
    $one + $two
}

try
{
    Add-Numbers a b
}
catch
{
    Write-Error $_
}
Add-Numbers 1 2
Add-Numbers 1 2 3
Add-Numbers -one 1

#* [PSDefaultValue(Help = '100')] #useful for auto gen help
function Get-SmallFiles
{
    Param(
        [PSDefaultValue(Help = '1mb')]
        $Size = 1mb
    )
    $args

    Get-ChildItem $HOME | Where-Object {
        $_.Length -lt $Size -and !$_.PSIsContainer }
}

Get-SmallFiles 1mb 222 333 444

#* $args[0] positional param

#* switch param

#param ([switch]$on)
#if ($on) { "Switch on" }
#else { "Switch off" }

#* Splatting: forward args
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting?view=powershell-7.4
# Splatting, in general speaking , is to pass a hashtable
# Syntax:
# <CommandName> <optional parameters> @<HashTable> <optional parameters>
# <CommandName> <optional parameters> @<Array> <optional parameters>

#** forward a hashtable
$HashArguments = @{
    Path = "test.txt"
    Destination = "test2.txt"
    WhatIf = $true
}
Copy-Item @HashArguments

#** forward an array
$ArrayArguments = "test.txt", "test2.txt"
Copy-Item @ArrayArguments -WhatIf

#** filter before forward
function Test1
{
    param($a, $b, $c)

    $a
    $b
    $c
}

function Test2
{
    param($a, $b, $c)

    #Call the Test1 function with $a, $b, and $c.
    Test1 @PsBoundParameters

    #Call the Test1 function with $b and $c, but not with $a
    $LimitedParameters = $PSBoundParameters
    $LimitedParameters.Remove("a") | Out-Null
    Test1 @LimitedParameters
}


Test2 1 2 3

#**Example
# @Args:@Args represents all the parameters of the Get-Process cmdlet.
function Get-MyCommand
{
    Param ([switch]$P, [switch]$C)
    if ($P)
    { Get-Process @Args
    }
    if ($C)
    {
        Get-Command @Args
    }
}

Get-MyCommand -P -C -Name PowerShell


#??
$array = 'Hello', 'World!'
Invoke-Command -ScriptBlock {
    param([string[]]$words) $words -join ' '
} -ArgumentList $array


Invoke-Command -ScriptBlock {
    param([string[]]$words) $words -join ' '
} -ArgumentList (,$array)





#* pipe in func
# begin/end: can't access $_
# process: can access $_
# end: if there is no process, the input is 1,2,3,4
function Get-Pipeline
{
    begin {
        "Begin: The input is $input"
    }
    process {
        "The value is: $_"
    }
    end {
        "End:   The input is $input"
    }
}
1, 2, 3, 4 | Get-Pipeline

# filter example
filter Get-ErrorLog([switch]$message)
{
    if ($message)
    {
        Out-Host -InputObject $_.Message
    }
    else
    {
        $_
    }
}

1, 2, 3, 4 | Get-ErrorLog -message | Get-Pipeline
#Output will be empty

1, 2, 3, 4 | Get-ErrorLog  | Get-Pipeline
#Output will be same

#* function is a ps provider!
Get-ChildItem function: # list functions
(Get-ChildItem function:help).Definition > help_impl.ps1
Get-ChildItem function:help | Get-Member > $null
