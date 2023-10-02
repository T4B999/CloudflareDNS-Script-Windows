@echo off
color 0A
title DNS Changer

:MENU
cls
echo Choose a DNS option:
echo.
echo 1 - Cloudflare Default DNS (IPv4 and IPv6)
echo 2 - Block Malware with 1.1.1.1 for Families (IPv4 and IPv6)
echo 3 - Block Malware and Adult Content with 1.1.1.1 for Families (IPv4 and IPv6)
echo.
set /p option="Enter the number of your choice (1/2/3) or press X to exit: "

if /i "%option%"=="X" (
    echo Exiting...
    timeout /t 2 >nul
    exit /b 0
)

:: Prompt the user to select Wi-Fi or Ethernet
cls
echo Select a network adapter:
echo.
echo 1 - Wi-Fi
echo 2 - Ethernet
echo.
set /p adapterChoice="Enter the number of your choice (1/2): "

:: Define the network adapter variable based on the user's choice
if "%adapterChoice%"=="1" (
    set "networkAdapter=Wi-Fi"
) else if "%adapterChoice%"=="2" (
    set "networkAdapter=Ethernet"
) else (
    echo Invalid choice. Please enter a valid option.
    timeout /t 2 >nul
    goto MENU
)

if "%option%"=="1" (
    set "preferredDNS=1.1.1.1"
    set "alternateDNS=1.0.0.1"
    set "ipv6PreferredDNS=2606:4700:4700::1111"
    set "ipv6AlternateDNS=2606:4700:4700::1001"
) else if "%option%"=="2" (
    set "preferredDNS=1.1.1.2"
    set "alternateDNS=1.0.0.2"
    set "ipv6PreferredDNS=2606:4700:4700::1112"
    set "ipv6AlternateDNS=2606:4700:4700::1002"
) else if "%option%"=="3" (
    set "preferredDNS=1.1.1.3"
    set "alternateDNS=1.0.0.3"
    set "ipv6PreferredDNS=2606:4700:4700::1113"
    set "ipv6AlternateDNS=2606:4700:4700::1003"
) else (
    echo Invalid choice. Please enter a valid option.
    timeout /t 2 >nul
    goto MENU
)

:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: This script requires administrative privileges.
    echo Please run this script as an administrator.
    pause
    exit /b 1
)

:: Change IPv4 DNS settings for the selected network adapter
echo Setting Preferred IPv4 DNS Server to %preferredDNS% for %networkAdapter%...
netsh interface ipv4 set dns "%networkAdapter%" static %preferredDNS% primary
echo Setting Alternate IPv4 DNS Server to %alternateDNS% for %networkAdapter%...
netsh interface ipv4 add dns "%networkAdapter%" %alternateDNS% index=2

:: Change IPv6 DNS settings for the selected network adapter
echo Setting Preferred IPv6 DNS Server to %ipv6PreferredDNS% for %networkAdapter%...
netsh interface ipv6 set dns "%networkAdapter%" static %ipv6PreferredDNS%
echo Setting Alternate IPv6 DNS Server to %ipv6AlternateDNS% for %networkAdapter%...
netsh interface ipv6 add dns "%networkAdapter%" %ipv6AlternateDNS%

echo DNS settings updated successfully for %networkAdapter%.

pause
exit /b 0
