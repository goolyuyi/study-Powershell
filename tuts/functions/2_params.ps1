#* Ref:
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7.4


#* [CmdletBinding]: some metadata
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced?view=powershell-7.4
#[CmdletBinding(ConfirmImpact=<String>,
#DefaultParameterSetName=<String>,
#HelpURI=<URI>,
#SupportsPaging=<Boolean>,
#SupportsShouldProcess=<Boolean>,
#PositionalBinding=<Boolean>)]
function Send-Greeting
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [string] $Name
    )

    {
        Write-Host ("Hello " + $Name + "!")
    }
}

#* Generic args:
#args: all args passed in
#$PSBoundParameters: only bound, aka. $ag
function Get-TheArgs
{
    param(
        $ag
    )
    $args | Format-List
    $PSBoundParameters
}

Get-TheArgs 1, 2, 3 -ag a b -aa c

#* Param's attributes
# * Mandatory
# * ValueFromPipeline
# * HelpMessage
# * switch
# * Position
#By default, all function parameters are positional.PowerShell assigns position numbers to parameters in the order
# in which the parameters are declared in the function.
# * ParameterSetName
# * Alias
# * [param type]
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

#* Param's validation attributes
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

#* Param from pipeline

#example of ValueFromPipelineByPropertyName
Function Get-Something
{
    [cmdletbinding()]
    Param (
        [parameter(ValueFromPipelineByPropertyName = $True)]
        [string[]]$Name,
        [parameter(ValueFromPipelineByPropertyName = $True)]
        [string[]]$Directory
    )
    Begin {
        Write-Verbose "Initialize stuff in Begin block"
    }

    Process {
        Write-Verbose "Process block"
        Write-Host "Name: $Name"
        Write-Host "Directory: $Directory"
    }

    End {
        Write-Verbose "Final work in End block"
        $Report
    }
}

Get-ChildItem | Get-Something

#* [OutputType] attribute
#Describes an attribute that reports the type of object that the function returns.
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_outputtypeattribute?view=powershell-7.4

#function SimpleFunction2
#{
#    [OutputType([<Type>])]
#    Param ($Parameter1)
#
#    <function body>
#}

function Send-Greeting
{
    [OutputType([String])]
    Param ($Name)

    "Hello, $Name"
}
(Get-Command Send-Greeting).OutputType