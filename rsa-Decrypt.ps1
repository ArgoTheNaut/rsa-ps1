# https://chatgpt.com/share/d2b771c8-0db2-44a0-a307-dceedaea99ce

param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$EncryptedString
)

# Load the private key
$pubKeyPath = "$PSScriptRoot/publicKey.xml"
$privKeyPath = "$PSScriptRoot/privateKey.xml"
$PrivateKey = Get-Content $privKeyPath
$RSA.FromXmlString($PrivateKey)

# Convert base64 string to byte array
$EncryptedData = [Convert]::FromBase64String($EncryptedString)

# Decrypt the data
$DecryptedData = $RSA.Decrypt($EncryptedData, $true)
[System.Text.Encoding]::UTF8.GetString($DecryptedData)
