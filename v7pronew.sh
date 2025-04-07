#!/bin/bash

echo_info() {
  echo -e "\033[1;32m[INFO]\033[0m $1"
}
echo_error() {
  echo -e "\033[1;31m[ERROR]\033[0m $1"
  exit 1
}

apt-get update; apt-get install curl socat git nload speedtest-cli -y



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
IBcNMjUwMzI4MTIyMjQ4WhgPMjEyNTAzMDQxMjIyNDhaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAyU4mu6Wt0R+Y
fMABv3gSusB+wtr0ZxlbjQbywR9MJXuvfksCwxUhYTCmyAen8hZCcOLBgAlM4o6/
uiNCCu8R0m5C9SRN5ZSVWCESpqXnMLulxGLZhRWkZ61jxOHRxoa2mkJHuylOA/Yf
sBlCKAo0ETEoDU8vSulsK70GPEmB+UIbVifipDgZu70k5FSTWE0VIzk5u2El9Ozb
l9CyqathELuU46MNVgCs6NIsmYUz26m0naPfGZcwljPrp1dhCaPmwHtvGshgStPW
X7PbIvjPgB+z2XLi0VQUD2bukqgRAZUiCMc31Q4nn95/CdryJg+R1D17bQJCgHe7
swuHEVLFC6Qd5CYHgrRALwD73lW83PXqwnIepa5Mt8Aurf7PdXFLjffE4/iJULwX
DjTx0munIxNTQmQB/hb7ejksqCCe9cnF/qB0f996Z/jGxoz4Z7E+8rTo270mi/U4
EH7QYvm7fix9EpvlJ8tSEIHiZkQ7WJFwN7YspKs54WgODIWlBPxte05LmFfceFI4
sOGSn2irObnjD/KPC37vp5BpL7FtHwiFwP+/GrZdxlU26/10sDPU0FmjLAMmYjxo
0BJkRuFx+El1j1sk4vroADD+0azu9c94n2g6hx4Idd8Tp9v/4NsBBICgdkvwiOid
fsY8qdgPGAwNtt7+WIPIV607+yxpIDMCAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
C7buNRp7JxuL7++zhDVTAflYPuZ8eBwvuBk+SNRME0ar/DRcPbOx63nQTpWJU0q4
/CuRQjDwr7JGOFCTCViq+BCNLmYSBdLPF4tz9tszMcaXBs0kTsbB3LWDijKlSuuO
dRd6AtoUvoL+NeDXl1jKnxsI9JnLr/073VxhV2isYhs/OATNaK+IMHDQnNDzXDM2
oKNcFQ8WBfGthoofjQUq4FwzXnSA61KgsFoOdHrsjDed/yJmB5ytyGAdIounrQnr
1Y2yLUJ1XunAB0ICbFpIZMbS4Djdxm/wXIpvOrXVbHimGJwVLYwNCDAmUJcfqBGU
oYTT97GQrgWdBXed27YTfm7B2V6eUgok2wyxRkBU78+pN9Rq70vMnTua00GZNLZ2
CfFrIO1Lw2/lDOW4XvrMEcuLTogmaveYuGMU+QqGbZm0cMmTKwVOUpK5Ci4e5+mN
gFPaI06Ud2A5nn2bl6revkaS4CQ8rifPHcZSQvtUjx+a71Ly5RYn0wT2bOgSJ8t2
WaNSjLJZ0KrUVWPcQBHoP+K6+8SZNZC/OIpLBHT7pr2kYaNYVsj5z54LLsCQSB+m
F9i6EwqS5498kbqBNHtKDm6X1hngwTPwP+tpBsqqs4HUW9Sm1uzzbgFk/IT7Rmfo
ltV4icBEiBCSaQ1O4BIZkhajOiDY0jaeHVoGfsqGrwI=
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
speedtest
