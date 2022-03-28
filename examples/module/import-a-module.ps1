Set-Location $PSScriptRoot

#Only modules that are stored in the location specified by the PSModulePath environment variable are automatically imported.
$env:PSModulePath

Import-Module ./MyScriptModule.psm1

Get-MrPSVersion

Get-Module -Name MyScriptModule

New-ModuleManifest -Path .\MyScriptModule.psd1 -RootModule MyScriptModule -Author 'Mike F Robbins' -Description 'MyScriptModule' -CompanyName 'mikefrobbins.com'