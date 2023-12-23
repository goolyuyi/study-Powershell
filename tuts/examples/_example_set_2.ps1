# Out-Null
Get-Help Get-Help | Out-Null

# list all about articles
Get-Help -Name About_*

# list all verbs
Get-Verb

#* useful alias
# % for ForEach-Object
# ? for Where-Object

#* param type
# mandatory: -Filter <string>
# optional: [[-Name] <String[]>]
# mandatory positional: [-Identity] <ADUser>
# switch: [-Recurse]
# array: [[-Name] <String[]>]


#* get attributes of a parameter
(Get-Command Stop-Process).Parameters.InputObject.Attributes
#Output:
#Mandatory                       : True
#ValueFromPipeline               : True
#ValueFromPipelineByPropertyName : False
#ValueFromRemainingArguments     : False


#* Get-Help about_CommonParameters
# common parameters:
# * Debug
# * ErrorAction
# * ErrorVariable
# * InformationAction
# * InformationVariable
# * OutBuffer
# * OutVariable
# * PipelineVariable
# * Verbose
# * WarningAction
# * WarningVariable
