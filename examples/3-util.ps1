Get-ChildItem | Format-Table -Property Size, Name

@(1, 2, 3) | Measure-Object
@{ "One" = 1; "Two" = 2 } | Measure-Object

