#!/bin/bash
PASSWORD=changeit
DNAME="CN=ods.example.com, OU=IT, O=MyCompany, L=Bangkok, S=BKK, C=TH"

echo "[*] Generating Kafka broker keystore..."
keytool -genkeypair -alias kafka \
 -dname "$DNAME" \
 -keyalg RSA \
 -keysize 2048 \
 -keystore kafka.keystore.jks \
 -storepass $PASSWORD \
 -keypass $PASSWORD \
 -validity 365

echo "[*] Exporting broker certificate..."
keytool -export -alias kafka \
 -keystore kafka.keystore.jks \
 -file kafka.broker.cert \
 -storepass $PASSWORD \
 -rfc

echo "[*] Creating truststore and importing broker certificate..."
keytool -import -noprompt -alias kafka \
 -file kafka.broker.cert \
 -keystore kafka.truststore.jks \
 -storepass $PASSWORD

echo "[✔] SSL Keystore & Truststore Ready"
