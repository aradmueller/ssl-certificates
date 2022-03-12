# Self signed SSL/TLS Certificates

- Private Key (*.key)
- Certificate Signing Request (*.csr)
- Self Signed Certificate (*.crt)

---

### create Private Key

create a password-protected, AES128 encrypted, 4096-bit RSA private key 
```
openssl genrsa -aes128 -out MyServer.key 4096
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

