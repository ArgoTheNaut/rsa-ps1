# https://chatgpt.com/share/d2b771c8-0db2-44a0-a307-dceedaea99ce

param([switch]$force = $false)
# Generate a new RSA key pair
$RSA = New-Object System.Security.Cryptography.RSACryptoServiceProvider

$pubKeyPath = "$PSScriptRoot/publicKey.xml"
$privKeyPath = "$PSScriptRoot/privateKey.xml"
if((Test-Path $pubKeyPath) -and -not $force){
    Write-Host "A public key already exists at $pubKeyPath`.  Aborting to avoid overwriting.  Use parameter -force to override this."
    exit
}

# Export the public key
$PublicKey = $RSA.ToXmlString($false)
Set-Content -Value $PublicKey -Path $pubKeyPath

# Export the private key
$PrivateKey = $RSA.ToXmlString($true)
Set-Content -Value $PrivateKey -Path $privKeyPath
