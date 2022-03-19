#<CommandName> <optional parameters> @<HashTable> <optional parameters>
#<CommandName> <optional parameters> @<Array> <optional parameters>
# Splatting, in general speaking , is to pass a hashtable

"t" > test.txt
$HashArguments = @{
    Path = "test.txt"
    Destination = "test2.txt"
    WhatIf = $true
}
Copy-Item @HashArguments

$ArrayArguments = "test.txt", "test2.txt"
Copy-Item @ArrayArguments -WhatIf


# Several cmdlets have an ArgumentList parameter that is used to pass parameter values to a script block that is executed by the cmdlet. The ArgumentList parameter takes an array of values that is passed to the script block. PowerShell is effectively using array splatting to bind the values to the parameters of the script block. When using ArgumentList, if you need to pass an array as a single object bound to a single parameter, you must wrap the array as the only element of another array.
$array = 'Hello', 'World!'
Invoke-Command -ScriptBlock {
    param([string[]]$words) $words -join ' '
} -ArgumentList $array
Invoke-Command -ScriptBlock {
    param([string[]]$words) $words -join ' '
} -ArgumentList (,$array)



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


function Get-MyCommand
{
    Param ([switch]$P, [switch]$C)
    if ($P) { Get-Process @Args
    }
    if ($C) { Get-Command @Args }
}

Get-MyCommand -P -C -Name PowerShell
