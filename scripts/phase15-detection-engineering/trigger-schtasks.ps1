# Phase 15 - Trigger Scheduled Task Command Detection
# Target custom Wazuh rule: 100203
# Parent Wazuh rule: 92032
# MITRE ATT&CK: T1053.005 - Scheduled Task
#
# Run this script on:
# SOC-Windows11-01
#
# Recommended shell:
# Administrator PowerShell
#
# Purpose:
# This script runs the Windows "schtasks /query" command to generate
# Sysmon Event ID 1 process creation telemetry and trigger the custom
# Wazuh detection rule 100203.

Write-Host "[Phase 15] Triggering scheduled task command detection test..." -ForegroundColor Cyan
Write-Host "[Phase 15] Expected Wazuh custom rule: 100203" -ForegroundColor Yellow
Write-Host "[Phase 15] MITRE ATT&CK: T1053.005 - Scheduled Task" -ForegroundColor Yellow
Write-Host ""

# This command queries scheduled tasks.
# Expected command-line telemetry may appear as:
# schtasks /query
# schtasks  /query
#
# The custom Wazuh rule uses PCRE2 matching for schtasks.

cmd.exe /c schtasks /query

Write-Host ""
Write-Host "[Phase 15] schtasks test completed." -ForegroundColor Green
Write-Host "[Phase 15] Validate on SOC-Ubuntu-Server-01 with:" -ForegroundColor Cyan
Write-Host "sudo grep '\"id\":\"100203\"' /var/ossec/logs/alerts/alerts.json | tail -5"
