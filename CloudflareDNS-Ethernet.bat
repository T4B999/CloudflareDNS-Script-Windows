@echo off
echo Changing IPv4 DNS settings to Cloudflare...
echo Please make sure you have administrative privileges.
echo.

rem Set Cloudflare DNS addresses
set dns1=1.1.1.1
set dns2=1.0.0.1

rem Prompt user for confirmation
echo This script will change your DNS settings to use Cloudflare's DNS servers.
set /p "confirmation=Continue? (Y/N): "
if /i "%confirmation%" neq "Y" (
    echo Script aborted.
    pause
    exit /b 1
)

rem Change the DNS settings to Cloudflare
echo Changing DNS settings...
netsh interface ipv4 set dns "Ethernet" static %dns1%
netsh interface ipv4 add dns "Ethernet" %dns2% index=2

echo DNS settings changed to Cloudflare:
netsh interface ipv4 show dns

echo.
echo DNS settings have been updated to use Cloudflare's DNS servers.
pause
