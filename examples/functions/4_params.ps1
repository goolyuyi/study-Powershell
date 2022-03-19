#cmdlet writes in c# or script
# add [CmdletBinding] make function act like a cmdlet

function Send-Greeting
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [string] $Name
    )

    Process
    {
        Write-Host ("Hello " + $Name + "!")
    }
}

"##############################"
function Get-AdvancedParams
{
    Param(
        [Parameter(Mandatory = $true,
                ValueFromPipeline = $true,
                HelpMessage = "Enter one or more computer names separated by commas.")]
        [string[]]
        $AAA,

        [switch]$BBB,

        [Parameter(Position = 0)]
        [string[]]
        $CCC,

        [Parameter(Mandatory,
                ParameterSetName = "SetA")]
        [string[]]
        $DDD,

        [Parameter(Mandatory,
                ParameterSetName = "SetB")]
        [string[]]
        $EEE,

        [Parameter(ParameterSetName = "SetA")]
        [Parameter(Mandatory, ParameterSetName = "SetB")]
        [switch]
        $FFF,

        [Alias("A", "Al")]
        $Alias,

        [string[]]
        [Parameter(Position = 1, ValueFromRemainingArguments)]
        $Remaining
    )

    DynamicParam
    {
        $da = "para:da"
        $db = "para:db"
        return $db
    }
    end{
        $PSBoundParameters
    }
}

Get-AdvancedParams -AAA "AAA" -BBB -CCC "CCC" -DDD "DDD"  -A aaa  -toRemain 1, 2, 3, 4


"##############################"

function Get-ValidatedParams
{
    Param(
        [AllowNull()]
        [hashtable]
        $AA,

        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]
        $BB,

        [ValidateCount(2, 5)]
        [ValidateLength(2, 10)]
        [string[]]
        $CC,

        [ValidatePattern("[0-9][0-9][0-9][0-9]")]
        [string]
        $DD,

        [ValidateRange(0, 10)]
        [Int]
        $EE,

        [ValidateScript({ $_ -ge (Get-Date) })]
        [DateTime]
        $FF,

        [ValidateSet("Low", "Average", "High")]
        [string[]]
        $GG

    #[ValidateNotNull()]
    #$HH,

    #[ValidateNotNullOrEmpty()]
    #[string[]]
    #$II

    #[ValidateDrive("C", "D", "Variable", "Function")]
    #[string]$Path

    #[Parameter(Mandatory, Position=0)][ValidateUserDrive()][string]$Path
    )
    $PSBoundParameters
}

Get-ValidatedParams -BB "" -CC aaa, bbb -DD 1996 -EE 4


#By default, all function parameters are positional.PowerShell assigns position numbers to parameters in the order in which the parameters are declared in the function.



