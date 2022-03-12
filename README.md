# Self signed SSL/TLS Certificates

Learn with this tutorial how to create a self-signed certificate with OpenSSL

- Private Key (*.key)
- Certificate Signing Request (*.csr)
- Self Signed Certificate (*.crt)

#### Requirement
[OpenSSL for Windows](https://slproweb.com/products/Win32OpenSSL.html)

---

### create Private Key

create a password-protected, AES128 encrypted, 4096-bit RSA private key 
```
openssl genrsa -aes128 -out MyServer.key 4096
```

### remove passphrase from Private Key

for compatibility reasons with web server passphrase must be removed
```
openssl rsa -in MyServer.key -out MyServer.key
```

### create Certificate Signing Request

create a certificate request with SHA-256 hash signature algorithm 
```
openssl req -new -sha256 -key MyServer.key -out MyServer.csr
```

### create Self Signed Certificate

create a certificate that's signed with its own private key 
```
openssl x509 -req -days 365 -signkey MyServer.key -in MyServer.csr -out MyServer.crt
```

### review Self Signed Certificate

show the contents of the certificate in plain text:
```
openssl x509 -text -noout -in MyServer.crt
```
