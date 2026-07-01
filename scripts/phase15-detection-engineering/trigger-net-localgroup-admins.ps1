# Phase 15 - Trigger Local Administrators Group Enumeration Detection
# Target custom Wazuh rule: 100202
# Parent Wazuh rule: 92036
# MITRE ATT&CK: T1069.001 - Local Groups
#
# Run this script on:
# SOC-Windows11-01
#
# Recommended shell:
# Administrator PowerShell
#
# Purpose:
# This script runs the Windows "net localgroup administrators" command
# to generate Sysmon Event ID 1 process creation telemetry and trigger
# the custom Wazuh detection rule 100202.

Write-Host "[Phase 15] Triggering local administrators group enumeration detection test..." -ForegroundColor Cyan
Write-Host "[Phase 15] Expected Wazuh custom rule: 100202" -ForegroundColor Yellow
Write-Host "[Phase 15] MITRE ATT&CK: T1069.001 - Local Groups" -ForegroundColor Yellow
Write-Host ""

# This command enumerates members of the local Administrators group.
# The custom Wazuh rule uses PCRE2 with \s+ to handle spacing differences.

cmd.exe /c "net localgroup administrators"

Write-Host ""
Write-Host "[Phase 15] net localgroup administrators test completed." -ForegroundColor Green
Write-Host "[Phase 15] Validate on SOC-Ubuntu-Server-01 with:" -ForegroundColor Cyan
Write-Host "sudo grep '\"id\":\"100202\"' /var/ossec/logs/alerts/alerts.json | tail -5"
