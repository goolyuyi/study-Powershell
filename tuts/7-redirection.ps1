#stream 1:log,2:err,3:warn,4:verbose,5:debug,6:info

# > overwrite >> append
# >&1 redirect

Get-ChildItem "./","path/error" > .\dir.log
Get-ChildItem "./","path/error" 2>&1

