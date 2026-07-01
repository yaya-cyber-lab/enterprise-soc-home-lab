# Phase 15 - Trigger Windows Failed Logon Detection
# Target custom Wazuh rule: 100204
# Parent Wazuh rule: 60122
# MITRE ATT&CK: T1110 - Brute Force
#
# Run this script on:
# SOC-Windows11-01
#
# Recommended shell:
# Administrator PowerShell
#
# Purpose:
# This script uses runas with a fake local username to generate a
# Windows Security Event ID 4625 failed logon event and trigger the
# custom Wazuh detection rule 100204.
#
# Important:
# When prompted for a password, enter any incorrect password.

Write-Host "[Phase 15] Triggering Windows failed logon detection test..." -ForegroundColor Cyan
Write-Host "[Phase 15] Expected Wazuh custom rule: 100204" -ForegroundColor Yellow
Write-Host "[Phase 15] MITRE ATT&CK: T1110 - Brute Force" -ForegroundColor Yellow
Write-Host ""
Write-Host "[Action Required] When prompted for a password, enter any incorrect password." -ForegroundColor Magenta
Write-Host ""

runas /user:%COMPUTERNAME%\fakeuser cmd

Write-Host ""
Write-Host "[Phase 15] Failed logon test command completed." -ForegroundColor Green
Write-Host "[Phase 15] Validate on SOC-Ubuntu-Server-01 with:" -ForegroundColor Cyan
Write-Host "sudo grep '\"id\":\"100204\"' /var/ossec/logs/alerts/alerts.json | tail -5"
