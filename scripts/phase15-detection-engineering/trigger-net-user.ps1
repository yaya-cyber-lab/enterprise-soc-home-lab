# Phase 15 - Trigger Local User Enumeration Detection
# Target custom Wazuh rule: 100201
# Parent Wazuh rule: 92036
# MITRE ATT&CK: T1087.001 - Local Account Discovery
#
# Run this script on:
# SOC-Windows11-01
#
# Recommended shell:
# Administrator PowerShell
#
# Purpose:
# This script runs the Windows "net user" command to generate
# Sysmon Event ID 1 process creation telemetry and trigger the custom
# Wazuh detection rule 100201.

Write-Host "[Phase 15] Triggering local user enumeration detection test..." -ForegroundColor Cyan
Write-Host "[Phase 15] Expected Wazuh custom rule: 100201" -ForegroundColor Yellow
Write-Host "[Phase 15] MITRE ATT&CK: T1087.001 - Local Account Discovery" -ForegroundColor Yellow
Write-Host ""

# This command enumerates local user accounts.
# Expected command-line telemetry may appear as:
# net user
# net  user
#
# The custom Wazuh rule uses PCRE2 with \s+ to handle spacing differences.

cmd.exe /c net user

Write-Host ""
Write-Host "[Phase 15] net user test completed." -ForegroundColor Green
Write-Host "[Phase 15] Validate on SOC-Ubuntu-Server-01 with:" -ForegroundColor Cyan
Write-Host "sudo grep '\"id\":\"100201\"' /var/ossec/logs/alerts/alerts.json | tail -5"
