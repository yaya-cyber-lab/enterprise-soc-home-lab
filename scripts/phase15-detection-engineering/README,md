# Phase 15 Detection Engineering Scripts

This folder contains scripts used to trigger and validate the custom Wazuh detection rules created during Phase 15 of the Enterprise SOC Home Lab.

These scripts support the Phase 15 documentation by making the detection tests repeatable and easier to validate.

---

## Folder Location

```text
scripts/phase15-detection-engineering/
```

---

## Purpose

The purpose of this folder is to store reusable scripts for Phase 15 detection engineering.

The scripts are used to:

- Trigger Windows endpoint telemetry
- Generate Sysmon process creation events
- Generate Windows Security failed logon events
- Validate custom Wazuh alerts from `alerts.json`
- Support repeatable detection testing
- Document practical SOC and detection engineering workflow

---

## Script List

| Script | Run On | Purpose | Rule ID | MITRE ATT&CK |
|---|---|---|---:|---|
| `trigger-encoded-powershell.ps1` | SOC-Windows11-01 | Trigger encoded PowerShell detection | 100200 | T1059.001 |
| `trigger-net-user.ps1` | SOC-Windows11-01 | Trigger local user enumeration detection | 100201 | T1087.001 |
| `trigger-net-localgroup-admins.ps1` | SOC-Windows11-01 | Trigger local administrators group enumeration detection | 100202 | T1069.001 |
| `trigger-schtasks.ps1` | SOC-Windows11-01 | Trigger scheduled task command detection | 100203 | T1053.005 |
| `trigger-failed-logon.ps1` | SOC-Windows11-01 | Trigger Windows failed logon detection | 100204 | T1110 |
| `wazuh-alert-validation-queries.sh` | SOC-Ubuntu-Server-01 | Validate Phase 15 Wazuh alerts from `alerts.json` | 100200-100204 | Multiple |

---

## Where to Run the Scripts

### Windows Endpoint

Run the PowerShell scripts on:

```text
SOC-Windows11-01
```

Recommended shell:

```text
Administrator PowerShell
```

PowerShell scripts:

```text
trigger-encoded-powershell.ps1
trigger-net-user.ps1
trigger-net-localgroup-admins.ps1
trigger-schtasks.ps1
trigger-failed-logon.ps1
```

---

### Wazuh Server

Run the Bash validation script on:

```text
SOC-Ubuntu-Server-01
```

Bash script:

```text
wazuh-alert-validation-queries.sh
```

---

## PowerShell Script Usage

Open PowerShell as Administrator on `SOC-Windows11-01`.

Navigate to the script folder:

```powershell
cd C:\Path\To\phase15-detection-engineering
```

Run a script:

```powershell
.\trigger-net-user.ps1
```

If script execution is blocked by PowerShell execution policy, run with bypass mode:

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\trigger-net-user.ps1
```

---

## Bash Script Usage

On `SOC-Ubuntu-Server-01`, navigate to the script folder:

```bash
cd scripts/phase15-detection-engineering
```

Make the validation script executable:

```bash
chmod +x wazuh-alert-validation-queries.sh
```

Run the validation script:

```bash
./wazuh-alert-validation-queries.sh
```

The script checks Wazuh alerts from:

```bash
/var/ossec/logs/alerts/alerts.json
```

---

## Detection Test Summary

### Rule 100200 - Encoded PowerShell

Script:

```text
trigger-encoded-powershell.ps1
```

Purpose:

```text
Triggers encoded PowerShell command execution.
```

Expected result:

```text
Wazuh custom rule 100200 is triggered.
```

MITRE ATT&CK:

```text
T1059.001 - PowerShell
```

---

### Rule 100201 - Local User Enumeration

Script:

```text
trigger-net-user.ps1
```

Purpose:

```text
Runs the net user command to enumerate local users.
```

Expected result:

```text
Wazuh custom rule 100201 is triggered.
```

MITRE ATT&CK:

```text
T1087.001 - Local Account
```

---

### Rule 100202 - Local Administrators Group Enumeration

Script:

```text
trigger-net-localgroup-admins.ps1
```

Purpose:

```text
Runs net localgroup administrators to enumerate members of the local Administrators group.
```

Expected result:

```text
Wazuh custom rule 100202 is triggered.
```

MITRE ATT&CK:

```text
T1069.001 - Local Groups
```

---

### Rule 100203 - Scheduled Task Command Execution

Script:

```text
trigger-schtasks.ps1
```

Purpose:

```text
Runs schtasks /query to generate scheduled task command telemetry.
```

Expected result:

```text
Wazuh custom rule 100203 is triggered.
```

MITRE ATT&CK:

```text
T1053.005 - Scheduled Task
```

---

### Rule 100204 - Windows Failed Logon

Script:

```text
trigger-failed-logon.ps1
```

Purpose:

```text
Uses runas with a fake local user to generate a failed logon event.
```

Expected result:

```text
Windows Security Event ID 4625 is generated and Wazuh custom rule 100204 is triggered.
```

MITRE ATT&CK:

```text
T1110 - Brute Force
```

---

## Alert Validation

After running the PowerShell trigger scripts, validate the alerts on the Wazuh Server using:

```text
wazuh-alert-validation-queries.sh
```

The validation script searches for these custom rule IDs:

```text
100200
100201
100202
100203
100204
```

Manual validation can also be performed with:

```bash
sudo tail -n 50000 /var/ossec/logs/alerts/alerts.json | jq -r '
select(.agent.name=="SOC-Windows11-01")
| select(
    .rule.id=="100200"
    or .rule.id=="100201"
    or .rule.id=="100202"
    or .rule.id=="100203"
    or .rule.id=="100204"
  )
| {
  timestamp: .timestamp,
  agent: .agent.name,
  rule_id: .rule.id,
  description: .rule.description,
  provider: .data.win.system.providerName,
  channel: .data.win.system.channel,
  eventID: .data.win.system.eventID,
  commandLine: .data.win.eventdata.commandLine,
  targetUserName: .data.win.eventdata.targetUserName,
  status: .data.win.eventdata.status
}'
```

---

## Expected Wazuh Custom Rules

| Rule ID | Description |
|---:|---|
| 100200 | Phase 15 - Custom detection: Encoded PowerShell command detected on Windows endpoint |
| 100201 | Phase 15 - Custom detection: Local user enumeration command detected |
| 100202 | Phase 15 - Custom detection: Local administrators group enumeration detected |
| 100203 | Phase 15 - Custom detection: Scheduled task command execution detected |
| 100204 | Phase 15 - Custom detection: Windows failed logon event detected |

---

## Related Documentation

Full Phase 15 documentation:

[../../docs/15-detection-engineering-final-documentation.md](../../docs/15-detection-engineering-final-documentation.md)

Main scripts folder:

[../README.md](../README.md)

Main project README:

[../../README.md](../../README.md)

---

## Safety Notice

These scripts are for controlled lab testing only.

They intentionally generate security-relevant telemetry for detection validation.

Do not run these scripts on production systems.

The scripts should only be used inside the Enterprise SOC Home Lab or another isolated testing environment.

---

## Skills Demonstrated

These scripts demonstrate:

- PowerShell-based event generation
- Bash-based Wazuh alert validation
- Sysmon telemetry testing
- Windows Security Event log testing
- Wazuh custom rule validation
- MITRE ATT&CK detection mapping
- Repeatable SOC lab testing workflow
