# Phase 15 - Trigger Encoded PowerShell Detection
# Target custom Wazuh rule: 100200
# Parent Wazuh rule: 92057
# MITRE ATT&CK: T1059.001 - PowerShell
#
# Run this script on:
# SOC-Windows11-01
#
# Recommended shell:
# Administrator PowerShell
#
# Purpose:
# This script executes a Base64-encoded PowerShell command to generate
# Sysmon Event ID 1 process creation telemetry and trigger the custom
# Wazuh detection rule 100200.

Write-Host "[Phase 15] Triggering encoded PowerShell detection test..." -ForegroundColor Cyan
Write-Host "[Phase 15] Expected Wazuh custom rule: 100200" -ForegroundColor Yellow
Write-Host "[Phase 15] MITRE ATT&CK: T1059.001 - PowerShell" -ForegroundColor Yellow
Write-Host ""

# Encoded command content:
# Write-Output "PHASE15_ENCODED_COMMAND_TEST"
#
# The command is encoded in UTF-16LE, which is required by PowerShell -EncodedCommand.

powershell.exe -NoProfile -ExecutionPolicy Bypass -EncodedCommand VwByAGkAdABlAC0ATwB1AHQAcAB1AHQAIAAiAFAASABBAFMARQAxADUAXwBFAE4AQwBPAEQARQBEAF8AQwBPAE0ATQBBAE4ARABfAFQARQBTAFQAIgA=

Write-Host ""
Write-Host "[Phase 15] Encoded PowerShell test completed." -ForegroundColor Green
Write-Host "[Phase 15] Validate on SOC-Ubuntu-Server-01 with:" -ForegroundColor Cyan
Write-Host "sudo grep '\"id\":\"100200\"' /var/ossec/logs/alerts/alerts.json | tail -5"
