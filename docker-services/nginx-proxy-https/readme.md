generate a crt and key with your domain.com

❯ openssl req -x509 -newkey rsa:4096 -keyout ssl_certificate.key -out ssl_certificate.crt -days 1825 -nodes -subj "/CN=google.com"

route google.com to ::1
