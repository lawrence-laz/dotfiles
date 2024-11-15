
openssl genrsa -out private-key.pem 3072
openssl rsa -in private-key.pem -pubout -out public-key.pem
openssl req -new -x509 -key private-key.pem -out public-key.cer -days 358000
winpty openssl pkcs12 -export -out private.pfx -inkey private-key.pem -in public-key.cer
