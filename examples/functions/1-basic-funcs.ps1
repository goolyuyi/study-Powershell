function Get-PowerShellProcess
{
    Get-Process pwsh
}

Get-PowerShellProcess 

"##############################"

#Syntax:
#   function [<scope:>]<name>
#   {
#   param([type]$parameter1 [,[type]$parameter2])
#   dynamicparam {<statement list>}
#   begin {<statement list>}
#   process {<statement list>}
#   end {<statement list>} # end is DEFAULT
#   }


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

#a little bit formal define
function Get-SmallFiles
{
    Param(
        [PSDefaultValue(Help = '1mb')]
        $Size = 1mb
    )
    $args

    Get-ChildItem $HOME | Where-Object {
        $_.Length -lt $Size -and !$_.PSIsContainer
    }
}

Get-SmallFiles 1mb 222 333 444
#help Get-SmallFiles # auto gen help
