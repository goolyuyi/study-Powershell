$folderA = "A"
$folderB = "B"

# Iterate through folder A
Get-ChildItem $folderA | ForEach-Object {
    $itemA = $_
    $itemBPath = Join-Path $folderB $itemA.Name

    # Check if the item exists in folder B
    if (Test-Path $itemBPath) {
        $itemB = Get-Item $itemBPath

        # Check if the item in folder B is a symbolic link or junction
        if (($itemB.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -ne 0) {
            # Replace with a symbolic link from folder A
#            Remove-Item $itemBPath -Force
#            New-Item -ItemType SymbolicLink -Path $itemBPath -Value $itemA.FullName
            Write-Information "Replace $itemB with $itemA linked."
        } else {
            # Item is not a link, discard and warn
            Write-Warning "Item $itemBPath is not a link and will be discarded."
        }
    } else {
#        New-Item -ItemType SymbolicLink -Path $itemBPath -Value $itemA.FullName
        Write-Information "Item $itemA linked."
    }
}

Write-Host "Operation completed."