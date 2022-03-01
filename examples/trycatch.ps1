try {
  NonsenseString
  Write-Output "aaaa"
  throw "This is an error."
}
catch {
  Write-Host "An error occurred:"
  Write-Host $_
}

Write-Output "bbbb"