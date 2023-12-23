#* Get-Help about_Preference_Variables
# -Confirm: yes
# -WhatIf: dryrun

#* Confirm Level
#can impl different lvl of confirm: if bigger than lvl then auto confirm
#   -ConfirmPreference: decide if a command should prompt, Default is 'High'
#   -ConfirmImpact: The decision to prompt is based on a comparison of ConfirmPreference with ConfirmImpact when set by a command author
#   lvl: High,Medium,Low

#** list all 'High' confirmimpact commands
Get-Command -CommandType Cmdlet, Function | Where-Object {
    $metadata = [System.Management.Automation.CommandMetadata]$_
    $metadata.ConfirmImpact -eq 'High'
}

#** will auto confirm
Clear-RecycleBin

#** explicit
Clear-RecycleBin -Confirm:$false

#** show
$ConfirmPreference

#** set ConfirmImpact
#[CmdletBinding(ConfirmImpact = 'High')]

#** get
[System.Management.Automation.CommandMetadata](Get-Command Remove-Item)

#* WhatIf
#** WhatIfPreference: think as global WhatIf
$WhatIfPreference = $true

