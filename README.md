# PowerShell RSA

A set of minimal wrapper scripts for quick use of RSA with locally stored public/private keys.

DISCLAIMER: This is not robust software.  It has not been rigorously tested to work with all file types and strange/non-ASCII byte sequences.  I threw this together quickly to see if it was possible to send a secure string to a friend without needing to install any additional software on windows.  There are definitely better and more robust ways to do this.

# Setup

Once the repository is cloned, just run the following command to create the public/private key pair.

```ps1
./rsa-KeyGen.ps1
```

# Use

## Encryption
Use `./rsa-Encrypt.ps1` to encode data:  
By default, the secret string will be output to `EncryptedMessage.txt` in your current working directory.

```ps1
.\rsa-Encrypt.ps1 -Message "Here be dragons"
gc .\EncryptedMessage.txt
RKGWc4c4qe+oSb+s1J7CB/sJBwSPV/tDkIEgUOKlHbpRO/k38PIijWvo4JfEDuFZUPeqYq0REJW6h4BmJaxfx9LlnneaxnzA9cve4DJ8IQkunK6sOmlt8rBeGzHdG0VJ2P5fAv1Q1EdXH9FA/B6aVScJ+j+eVHSHULQSfx3g0yM
```

```ps1
"Some secret string" | .\rsa-Encrypt.ps1
```

```ps1
.\rsa-Encrypt.ps1
Enter your message to be encrypted: ***************
```

## Decryption

Use `./rsa-Decrypt.ps1` to decode data:

```ps1
gc .\EncryptedMessage.txt | .\rsa-Decrypt.ps1
Here be dragons
```
