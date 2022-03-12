#!/bin/sh

echo create RootCA
openssl genrsa -aes128 -passout pass:PwdRootCA -out RootCA.key 4096
openssl req -new -x509 -days 365 -config ./config/RootCA.cfg -extensions v3_ca -passin pass:PwdRootCA -key RootCA.key -out RootCA.crt

echo create IntermediateCA
openssl genrsa -aes128 -passout pass:PwdIntermediateCA -out IntermediateCA.key 4096
openssl req -new -sha256 -config ./config/IntermediateCA.cfg -passin pass:PwdIntermediateCA -key IntermediateCA.key -out IntermediateCA.csr
openssl x509 -req -days 365 -extfile ./config/IntermediateCA.cfg -extensions v3_intermediate_ca -in IntermediateCA.csr -CAcreateserial -CA RootCA.crt -CAkey RootCA.key -passin pass:PwdRootCA -out IntermediateCA.crt
openssl verify -CAfile RootCA.crt IntermediateCA.crt

echo create mypage.com certificate
openssl genrsa -aes128 -passout pass:PwdSrvCrt -out mypage.com.key 4096
openssl req -new -sha256 -config ./config/mypage.com.cfg -passin pass:PwdSrvCrt -key mypage.com.key -out mypage.com.csr
openssl x509 -req -days 365 -extfile ./config/mypage.com.cfg -extensions v3_server_cert -in mypage.com.csr -CAcreateserial -CA IntermediateCA.crt -CAkey IntermediateCA.key -passin pass:PwdIntermediateCA -out mypage.com.crt
openssl verify -CAfile RootCA.crt -untrusted IntermediateCA.crt mypage.com.crt

echo done
