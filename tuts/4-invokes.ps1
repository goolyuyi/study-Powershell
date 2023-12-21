#invoke from string
$Command = "echo ""a b c"""
Invoke-Expression -Command $Command

#invoke from string
&("help")
&("ipconfig")