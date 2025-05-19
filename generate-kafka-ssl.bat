@echo off
setlocal

:: Set variables
set PASSWORD=changeit
:: "CN=ods.example.com, OU=IT, O=Excise, L=Bangkok, S=BKK, C=TH"
set DNAME=CN=localhost, OU=Dev, O=MyCompany, L=City, S=State, C=TH

echo.
echo [*] Generating Kafka broker keystore...
keytool -genkey ^
 -alias kafka ^
 -dname "%DNAME%" ^
 -keystore kafka.broker.keystore.jks ^
 -keyalg RSA ^
 -storepass %PASSWORD% ^
 -keypass %PASSWORD% ^
 -validity 365

echo.
echo [*] Exporting Kafka broker certificate...
keytool -export ^
 -alias kafka ^
 -file kafka.broker.cert ^
 -keystore kafka.broker.keystore.jks ^
 -storepass %PASSWORD%

echo.
echo [*] Creating Kafka client truststore and importing broker certificate...
keytool -import ^
 -alias kafka ^
 -file kafka.broker.cert ^
 -keystore kafka.client.truststore.jks ^
 -storepass %PASSWORD% ^
 -noprompt

echo.
echo [*] Generating Kafka client keystore...
keytool -genkey ^
 -alias client ^
 -dname "%DNAME%" ^
 -keystore kafka.client.keystore.jks ^
 -keyalg RSA ^
 -storepass %PASSWORD% ^
 -keypass %PASSWORD% ^
 -validity 365

echo.
echo [*] Exporting Kafka client certificate...
keytool -export ^
 -alias client ^
 -file kafka.client.cert ^
 -keystore kafka.client.keystore.jks ^
 -storepass %PASSWORD%

echo.
echo [*] Creating Kafka broker truststore and importing client certificate...
keytool -import ^
 -alias client ^
 -file kafka.client.cert ^
 -keystore kafka.broker.truststore.jks ^
 -storepass %PASSWORD% ^
 -noprompt

echo.
echo [✔] All SSL keystore and truststore files have been generated successfully.

endlocal
pause
