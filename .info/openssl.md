# generate random passwords

openssl rand -base64 12

## extract ca certificate

openssl s_client -connect <mysite.com>:443 -showcerts </dev/null 2>/dev/null | openssl x509 -outform PEM > registry_ca_cert.pem

# test site certificate

- test handshake
  openssl s_client -connect google.com:443

- show certs
  openssl s_client -connect example.com:443 -showcerts
