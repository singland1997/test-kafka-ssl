@echo off
setlocal

:: ===============================
:: CONFIG
:: ===============================
set PASSWORD=changeit
set DNAME=CN=ods.example.com, OU=IT, O=MyCompany, L=Bangkok, S=BKK, C=TH

:: ===============================
:: BROKER KEYSTORE
:: ===============================
echo [*] Generating Kafka broker keystore...
keytool -genkeypair -alias kafka ^
 -dname "%DNAME%" ^
 -keyalg RSA ^
 -keysize 2048 ^
 -keystore kafka.keystore.jks ^
 -storepass %PASSWORD% ^
 -keypass %PASSWORD% ^
 -validity 365

echo [*] Exporting broker certificate...
keytool -export -alias kafka ^
 -keystore kafka.keystore.jks ^
 -file kafka.broker.cert ^
 -storepass %PASSWORD% ^
 -rfc

:: ===============================
:: CLIENT TRUSTSTORE
:: ===============================
echo [*] Creating client truststore and importing broker cert...
keytool -import -noprompt -alias kafka ^
 -file kafka.broker.cert ^
 -keystore kafka.truststore.jks ^
 -storepass %PASSWORD%

echo.
echo [✔] Done! Files created:
echo     kafka.keystore.jks
echo     kafka.truststore.jks
echo     kafka.broker.cert
echo.

pause
endlocal