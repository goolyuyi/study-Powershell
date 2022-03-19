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
"##############################"
function Get-PipelineBeginEnd
{
    begin {
        "Begin: The input is $input"
    }
    end {
        "End:   The input is $input"
    }
}
1, 2, 3, 4 | Get-PipelineBeginEnd
"##############################"
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
"##############################"
1, 2, 3, 4 | Get-ErrorLog  | Get-Pipeline

"##############################"
#function is a ps provider!
Get-ChildItem function: # list functions
(Get-ChildItem function:help).Definition > help_impl.ps1
Get-ChildItem function:help | Get-Member > $null

