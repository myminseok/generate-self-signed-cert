# for rootca.crt
openssl genrsa -out rootca.key 2048
openssl req -new -key rootca.key -config template-rootca-openssl.conf -out rootca.csr
openssl x509 -req -days 3650 -set_serial 1 -in rootca.csr -signkey rootca.key -out rootca.crt -extfile template-rootca-openssl.conf 


#for domain.key, domain.csr
openssl genrsa -out domain.key 2048
openssl req -new -key domain.key -config template-targetdomain-openssl.conf -out domain.csr
openssl req -text -nout -verify -in domain.csr

# for domain.crt
openssl x509 -req -days 3650 -extensions v3_user -in domain.csr -CA rootca.crt -CAcreateserial -CAkey rootca.key -out domain.crt -extfile template-targetdomain-openssl.conf
openssl x509 -text -in domain.crt


