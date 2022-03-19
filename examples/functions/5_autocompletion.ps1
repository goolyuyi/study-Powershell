#you can use `Tab` key
function Test1
{
    Param(
        [ValidateSet('hello', 'world')]
        [string]$Message,

        [ArgumentCompletions('Fruits', 'Vegetables')]
        $Type
    )

    $Message = 'bye'
}


function MyArgumentCompleter
{
    param ($commandName,
        $parameterName,
        $wordToComplete,
        $commandAst,
        $fakeBoundParameters)

    $possibleValues = @{
        Fruits = @('Apple', 'Orange', 'Banana')
        Vegetables = @('Tomato', 'Squash', 'Corn')
    }

    if ( $fakeBoundParameters.ContainsKey('Type'))
    {
        $possibleValues[$fakeBoundParameters.Type] | Where-Object {
            $_ -like "$wordToComplete*"
        }
    }
    else
    {
        $possibleValues.Values | ForEach-Object { $_ }
    }
}

function Test-ArgumentCompleter
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Fruits', 'Vegetables')]
        $Type,

        [Parameter(Mandatory = $true)]
        [ArgumentCompleter({ MyArgumentCompleter @args })]
        $Value
    )
}
