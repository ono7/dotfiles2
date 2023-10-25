# generate random passwords

openssl rand -base64 12

# test site certificate

- test handshake
  openssl s_client -connect google.com:443

- show certs
  openssl s_client -connect example.com:443 -showcerts
