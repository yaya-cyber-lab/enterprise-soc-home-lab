# Scripts

This folder contains scripts used to trigger and validate security events in the Enterprise SOC Home Lab.

The scripts are used for controlled lab testing, detection validation, and documentation purposes.

---

## Folder Structure

```text
scripts/
└── phase15-detection-engineering/
    ├── README.md
    ├── trigger-encoded-powershell.ps1
    ├── trigger-net-user.ps1
    ├── trigger-net-localgroup-admins.ps1
    ├── trigger-schtasks.ps1
    ├── trigger-failed-logon.ps1
    └── wazuh-alert-validation-queries.sh
```

---

## Purpose

The purpose of these scripts is to make detection testing repeatable.

Instead of manually typing every command each time, the scripts can be used to consistently generate Windows endpoint telemetry and validate Wazuh alerts.

The scripts help validate:

- Encoded PowerShell execution
- Local user enumeration
- Local administrators group enumeration
- Scheduled task command execution
- Windows failed logon events
- Wazuh custom detection rules
- Phase 15 detection engineering results

---

## Script Categories

| Folder | Description |
|---|---|
| `phase15-detection-engineering/` | Scripts used to trigger and validate Phase 15 custom Wazuh detection rules |

---

## Where to Run the Scripts

PowerShell scripts are executed on the Windows endpoint:

```text
SOC-Windows11-01
```

Bash scripts are executed on the Wazuh Server:

```text
SOC-Ubuntu-Server-01
```

---

## Phase 15 Detection Engineering Scripts

| Script | Run On | Purpose | Rule ID |
|---|---|---|---:|
| `trigger-encoded-powershell.ps1` | SOC-Windows11-01 | Trigger encoded PowerShell detection | 100200 |
| `trigger-net-user.ps1` | SOC-Windows11-01 | Trigger local user enumeration detection | 100201 |
| `trigger-net-localgroup-admins.ps1` | SOC-Windows11-01 | Trigger local administrators group enumeration detection | 100202 |
| `trigger-schtasks.ps1` | SOC-Windows11-01 | Trigger scheduled task command detection | 100203 |
| `trigger-failed-logon.ps1` | SOC-Windows11-01 | Trigger Windows failed logon detection | 100204 |
| `wazuh-alert-validation-queries.sh` | SOC-Ubuntu-Server-01 | Validate Phase 15 Wazuh alerts from `alerts.json` | 100200-100204 |

---

## PowerShell Usage

Run the PowerShell scripts from an Administrator PowerShell session on:

```text
SOC-Windows11-01
```

Example:

```powershell
.\trigger-net-user.ps1
```

If PowerShell execution policy blocks the script, run the script with bypass mode:

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\trigger-net-user.ps1
```

---

## Bash Usage

Run the Bash validation script from the Wazuh Server:

```text
SOC-Ubuntu-Server-01
```

Make the script executable:

```bash
chmod +x wazuh-alert-validation-queries.sh
```

Run the script:

```bash
./wazuh-alert-validation-queries.sh
```

---

## Safety Notice

These scripts are for controlled lab testing only.

They are designed to generate security telemetry in an isolated home lab environment. They should not be used on production systems.

Some scripts intentionally generate suspicious or security-relevant activity, including:

- Encoded PowerShell execution
- Account discovery commands
- Local group enumeration
- Scheduled task command activity
- Failed logon attempts

---

## Related Documentation

Main project README:

[../README.md](../README.md)

Phase 15 documentation:

[../docs/15-detection-engineering-final-documentation.md](../docs/15-detection-engineering-final-documentation.md)

Phase 15 detection engineering scripts:

[phase15-detection-engineering/](phase15-detection-engineering/)

---

## Notes

These scripts support the GitHub documentation by showing that the detection workflow can be repeated and validated.

They demonstrate practical SOC skills including:

- PowerShell-based event generation
- Bash-based alert validation
- Wazuh alert review
- Sysmon telemetry validation
- Windows Security Event log validation
- Custom detection rule testing
