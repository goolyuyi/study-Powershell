#* Write Host with color
$Colors = @{ ForegroundColor = "black"; BackgroundColor = "white" }
Write-Host "This is a test." @Colors
Write-Host @Colors "This is another test."


#* Get PSReadLine
Get-PSReadLineOption
Get-PSReadLineKeyHandler

#* Set PSStyle
"$( $PSStyle.Background.BrightCyan )Power$( $PSStyle.Underline )$( $PSStyle.Bold )Shell$( $PSStyle.Reset )"

# show all alias
function Get-CmdletAlias($cmdletname)
{
    Get-Alias |
            Where-Object -FilterScript { $_.Definition -like "$cmdletname" } |
            Format-Table -Property Definition, Name -AutoSize
}


#* human readable filesize
Get-ChildItem |
        Select-Object -Property Mode, LastWriteTime, @{ Name = 'SizeInKb'; Expression = { [double]('{0:N2}' -f ($_.Length/1kb)) } }, Name |
        Sort-Object -Property SizeInKb

function Get-FriendlySize
{
    param($Bytes)
    $sizes = 'Bytes,KB,MB,GB,TB,PB,EB,ZB' -split ','
    for($i = 0; ($Bytes -ge 1kb) -and
            ($i -lt $sizes.Count); $i++) {
        $Bytes /= 1kb
    }
    $N = 2; if ($i -eq 0)
    {
        $N = 0
    }
    "{0:N$( $N )} {1}" -f $Bytes, $sizes[$i]
}

Get-ChildItem  | Select-Object -Property Mode, LastWriteTime, @{ N = 'FriendlySize'; E = { Get-FriendlySize -Bytes $_.Length } }, Name
