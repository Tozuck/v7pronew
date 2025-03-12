#!/bin/bash

echo_info() {
  echo -e "\033[1;32m[INFO]\033[0m $1"
}
echo_error() {
  echo -e "\033[1;31m[ERROR]\033[0m $1"
  exit 1
}

apt-get update; apt-get install curl socat git nload -y

if ! command -v docker &> /dev/null; then
  curl -fsSL https://get.docker.com | sh || echo_error "Docker installation failed."
else
  echo_info "Docker is already installed."
fi

rm -r Marzban-node

git clone https://github.com/Gozargah/Marzban-node

rm -r /var/lib/marzban-node

mkdir /var/lib/marzban-node

rm ~/Marzban-node/docker-compose.yml

cat <<EOL > ~/Marzban-node/docker-compose.yml
services:
  marzban-node:
    image: gozargah/marzban-node:latest
    restart: always
    network_mode: host
    environment:
      SSL_CERT_FILE: "/var/lib/marzban-node/ssl_cert.pem"
      SSL_KEY_FILE: "/var/lib/marzban-node/ssl_key.pem"
      SSL_CLIENT_CERT_FILE: "/var/lib/marzban-node/ssl_client_cert.pem"
      SERVICE_PROTOCOL: "rest"
    volumes:
      - /var/lib/marzban-node:/var/lib/marzban-node
EOL

cat <<EOL > /var/lib/marzban-node/ssl_client_cert.pem
-----BEGIN CERTIFICATE-----
MIIEnDCCAoQCAQAwDQYJKoZIhvcNAQENBQAwEzERMA8GA1UEAwwIR296YXJnYWgw
IBcNMjUwMzEyMTY1MDE3WhgPMjEyNTAyMTYxNjUwMTdaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAlZWJYADWxHwZ
CyMIZTRKHSbl/KljpKYXzI77kwmqhDH+PEXH2oGFBhfO2+TqlhxX8oBCrRnpqbW8
WxiwOt7IRa/zcWj1nFqXqvzc85X2kJIgd4wxMjtieZLSbCPT/7DZt8nVEgaiPfn6
fJhh3bJf2DVvWntGXI7peFrh9p+DD+CY5ApjR1yJDYontw65afaGAy8YzK/XKLrw
qkIBzpQcJ74kBC9fw0dOsBWOGxrTqkgJ9y2OMhIz1QrtpccARPjssbpmAD6eHZq2
xAmfaxmS/LXj849i0STaLY61pycQ0QsPjtn9GbtNtkA7qUt+7pqpywkTcSGrzD4O
shQY0IUG/zp5zPG2HDWMbAZtbxBnZqu/+bf6CZp+ysiYxKvUrzn9IAeVjalJ9kza
HAhTzM1a5qdbycPHnVxJehk6fgwZRGfT2P4Ml16BV+4YsLfudLfn2KqqCf/WYkjz
njD7ilzAlDuOmq2d0khdWGn0oP4de757g4zoGrUykhqe+8SWpaHEHi9DhS1+x21F
SFrLlCmxxfNUhScycu/JwAmV2mIK+uObxPz1SoL0H/oyUpn743N34l0QJrxQVTSJ
FNvS9qL1IR7KeYzARhFaaw8G5OtOhnErGoCYwp5qaOhoSAFX9Ksq4GUOCtRt0x8Z
uQgAY5TWnpUx5w9uXXEMYKdv4a/5Wk8CAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
iVDDImwCQ66FDusOa6DMoe0JuDfFBcrzX/LAJ6ZFUYjKCtoYqTwh21c1+W+2kgeB
7H1tZfvaOvvqsvwIM2HdB3Ho9oufw3zqJifVsuCc51QknSwEN6pXd7AURYMwYikP
spiGujz90lrc4Pj0GUng83MWUehNWIE0X7NT/XjlplDSib+Drep1Uz7F9WZmuWx9
LqE8hVyy8nTyr/iVw28JUN4z5nYXeB2RabMX4/EFqkYupGsxgPg5PaQTEMdra5Os
mrxd95xePWwCnLdp65tyjYgJEIS9GGPPta2NGxA5GgSls2rIfo7veGKS2czZX5VR
Iy3UTP8vBMK8FCkK1269swW1c+i+S7Ll3fHyX7rTxhsYOqvzTMRBbx9ZA4WSN5Nv
n/bQIOGbXeYMnBWAhLcaizwATRMSgWtkN8emzrAb4IWk+BS7H5j6w8tBQn+WqQ55
SIvO23DyRxo33xk0em8zKiUro+4IOCYgiHRWP72tuCfJEsbV+Zp472/HxU79ySls
+9sfsszRDVx6sRe+8R9LUMry6rYI0IkmGaU73IfOJ9xk3TllT5bA8Xs/4sYtfJe/
ag/4FUeAU1nzvTSyGlcCuoGW1yTzGgP8cfD2uUxJdF2tHvUgAsk7GJEisRVDX/+U
hc0fch4P46OyUmi7gxRRhhAbuf5m/FBpzTP6edRWz8c=
-----END CERTIFICATE-----

-----BEGIN CERTIFICATE-----
MIIEnDCCAoQCAQAwDQYJKoZIhvcNAQENBQAwEzERMA8GA1UEAwwIR296YXJnYWgw
IBcNMjUwMzEyMTgyMTM2WhgPMjEyNTAyMTYxODIxMzZaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEApYjDCY2jDaeq
bSPpeJ2diwGdkq/1LPursS2l3OgWdVl5SkpVBZObyVvfi4Zfo6H4+iUsL8DUiAa2
jIKNgHxOe9wmGRmdR8Do0HzSd9aXDyQxB3C+BqSw2HkPAsn/OaS38Q6woTlyiKJ1
8KYvyakyF2inaay32HD75zTeIkgYiwcrDFwAXW3vCJTG7CSnuOHVlQGF1Xko05hj
TMylRghA9kYnxGrF5+6G1hZEleiF8ObuD6JvxGNdQfoSD/VKS7Fh0yvqtJPgmycs
ojeK9nVbKgk5OjDr0Kkf0GnLqZP246jkl1vv4jb4izAxcFxWSetCDkxIg1jsn7++
PT6o/fcj/C5fAu0WVofqnULbI1ZWy0D/NU8zJRzXfhu6mGtobTxz4vO+mET2DNjM
DnrUkY+1dvZhogfWt9dubKxitveO9D+RTTc4RkYqig+5TCM+HjGu3nIV2p8CY6Vh
Al4JI0gJTAo2HsS4tJazOqyGQ0yFuzYbRP5fJCBv2czl4KEq3rMQZ3wm/9Z+wn1Z
iVbGvljJ4WC5XWR4Kce4oYyUJ4kj0KBpM8QwI08M7968hFudch9PK5mYYG9Ukmlh
wXWJsadvpLO2LNAv2RWdGfS5ConMqsxgO+04DtmomfyK4OP03g/gFcMRPLI4kDrW
bAZJJcV00Y+LaX2aVqZSZGdl14tGhN0CAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
dK+hBwm4Au7hV9gV6YpSGsLTQXQurA0fi4sQOMgFG7pxxvvR54ra85nRwUaQb2B+
B/2342z/QDEY8EEWAncjjVsFdy79UWhy1DwU8AG3gntaoTqdvsyL/19REvV2PjXe
WZquiGaTUDXVVF03e1QSwGzEzpswZYcBXIADoUZJAfMqRUXAeFoicYtULP/meFQo
2CnIhh9ps1rBjD5cMYmlkTa4zvCTrXrDJleb9qdE+9wssVQ6M+jXAYrJJaPtassg
wKf9WfiO3LDoIKCZwH4LhtYSksR7yREPEbik217iqWNlr1fawhmk/5Z7wNJ2WO6R
dfsWNQbiJmBGt5Uw1kkvhp0nhcUKRHAoin4js4FiSS1dvj4qzdHnWydXFoo/29r5
VWJmOknzJlV/ELSFYAQUkun89+v+VK5oWbMGiQJVz/4nU9CLTYkvKoZBVGR0dNLM
SLo0pOWmBRPoaqlWus6MB+yWI+/JPVnXTAo4UcGL7WN6yVfW4lzwKuYUo74JGehM
yQbU+lynzru1szNKfNUUVmUSpuiuygsZf5D6T3evoT3XnaOjYQ6RjjI2chv0r1CI
NmOA0D9a6io2Qa47LHvGo3+/Gm7hxdZ/MGzRme4cvxlcAv5DymRQG+51tCxO/zz/
lA4wAgk8QTUAkxCwOSXOVMP7Nh/nf5iN804Rb5R9Gjo=
-----END CERTIFICATE-----
EOL

cd ~/Marzban-node
docker compose up -d

echo_info "Finalizing UFW setup..."

ufw allow 22
ufw allow 80
ufw allow 2096
ufw allow 8443
ufw allow 62050
ufw allow 62051

ufw --force enable
ufw reload
