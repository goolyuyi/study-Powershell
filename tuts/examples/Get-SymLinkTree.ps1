#function Get-SymLinkTree
#{
param (
    [string]$Path
)

$rootPath = Resolve-Path -Path $Path

# Helper function to display a tree structure
function Display-Tree($item, $depth)
{
    $indent = "--" * $depth
    $relativePath = Split-Path -Leaf $item.FullName

    # Check if the item is a symbolic link
    if ($item.Attributes -match 'ReparsePoint')
    {
        $target = Get-ItemProperty -Path $item.FullName -Name Target -ErrorAction SilentlyContinue
        "$indent $relativePath -> $( $target.Target )"
    }
    else
    {
        "$indent $relativePath"
    }
}

# Recursively process items in the folder
function Process-Items($path, $depth)
{
    Get-ChildItem -LiteralPath $path -ErrorAction SilentlyContinue | ForEach-Object {
        Display-Tree $_ $depth

        if (Test-Path -Path $_.FullName -PathType Container)
        {
            Process-Items $_.FullName ($depth + 1)
        }
    }
}

Process-Items $rootPath 0
#}


# Example Output:
# AA
# -- AAA
# ---- AAAA
# -- AAB
# BB
# -- b
# -- bb -> C:\test
# a
