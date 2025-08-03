@echo off
setlocal EnableDelayedExpansion

REM 1) Captura o IPv4 local
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /R "IPv4.*:"') do set MY_IP=%%A
set MY_IP=%MY_IP: =%
echo 🔍 Local IP: %MY_IP%

REM 2) Extrai os três primeiros octetos para criar o prefixo /24
for /f "tokens=1-3 delims=." %%A in ("%MY_IP%") do (
  set OCT1=%%A
  set OCT2=%%B
  set OCT3=%%C
)
set NETWORK=%OCT1%.%OCT2%.%OCT3%.

echo.
echo 🔍 Escaneando rede: %NETWORK%0/24
echo.

REM 3) Testa de 1 até 254 e exibe somente hosts ativos
for /L %%i in (1,1,254) do (
  ping -n 1 -w 100 %NETWORK%%%i >nul 2>&1
  if not errorlevel 1 (
    echo ✅ Ativo: %NETWORK%%%i
  )
)

echo.
echo ✔ Scan concluído.
pause