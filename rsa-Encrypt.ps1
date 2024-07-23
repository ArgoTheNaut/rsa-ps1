# rsa-Encrypt.ps1
# https://chatgpt.com/share/d2b771c8-0db2-44a0-a307-dceedaea99ce
param (
    [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
    [string]$Message,
    [string]$Path = "./EncryptedMessage.txt"
)

# Load the public key
$pubKeyPath = "$PSScriptRoot/publicKey.xml"
$privKeyPath = "$PSScriptRoot/privateKey.xml"

$PublicKey = Get-Content $pubKeyPath
$RSA = New-Object System.Security.Cryptography.RSACryptoServiceProvider
$RSA.FromXmlString($PublicKey)

function Convert-SecureStringToPlainText {
    param (
        [Parameter(Mandatory = $true)]
        [System.Security.SecureString]$SecureString
    )

    # Convert the SecureString to an IntPtr (pointer to unmanaged memory)
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)

    try {
        # Convert the IntPtr to a plain text string
        $PlainText = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($BSTR)
    } finally {
        # Free the unmanaged memory
        [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
    }

    return $PlainText
}

# Example usage
if(-not $Message){
    $secureString = Read-Host -AsSecureString "Enter your message to be encrypted"
    $Message = Convert-SecureStringToPlainText -SecureString $secureString
}

# Encrypt some data
$Data = [System.Text.Encoding]::UTF8.GetBytes($Message)
$EncryptedData = $RSA.Encrypt($Data, $true)

# Convert to base64 string for easy storage or transmission
$EncryptedString = [Convert]::ToBase64String($EncryptedData)
Set-Content -Path $Path -Value $EncryptedString
