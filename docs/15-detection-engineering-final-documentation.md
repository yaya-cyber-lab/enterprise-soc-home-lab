# Phase 15 - Detection Engineering and Final Documentation

## Overview

Phase 15 focused on custom detection engineering in the Enterprise SOC Home Lab.

The goal of this phase was to create, deploy, test, troubleshoot, and validate custom Wazuh detection rules for Windows endpoint activity collected from Sysmon and Windows Security logs.

This phase builds on the previous attack simulation and detection validation phase by moving from basic alert verification to custom rule development mapped to MITRE ATT&CK techniques.

---

## Lab Environment

| Component | Hostname | Role |
|---|---|---|
| Wazuh Server | SOC-Ubuntu-Server-01 | Wazuh Manager, Indexer, Dashboard |
| Windows Endpoint | SOC-Windows11-01 | Monitored Windows endpoint |
| Logging Source | Sysmon + Windows Security Logs | Endpoint telemetry |
| SIEM Platform | Wazuh | Detection and alerting |

---

## Detection Engineering Objectives

The objectives of this phase were:

- Create custom Wazuh detection rules
- Collect Windows Sysmon process creation events
- Collect Windows Security failed logon events
- Map detections to MITRE ATT&CK techniques
- Validate alerts from both Ubuntu CLI and Wazuh Dashboard
- Troubleshoot rule matching issues
- Confirm all custom rules trigger successfully

---

## Custom Rule File

Custom detection rules were created in the following Wazuh Manager rule file:

```bash
/var/ossec/etc/rules/phase15_windows_detection_rules.xml
```

The rule file was edited on the Wazuh server:

```bash
sudo nano /var/ossec/etc/rules/phase15_windows_detection_rules.xml
```

After editing the rule file, the Wazuh Manager service was restarted:

```bash
sudo systemctl restart wazuh-manager
```

The service status was verified:

```bash
sudo systemctl status wazuh-manager --no-pager
```

The Wazuh Manager successfully loaded the updated rules.

---

## Windows Agent Sysmon Collection

The Windows Wazuh Agent was configured to collect Sysmon Operational logs.

The following configuration was present in:

```powershell
C:\Program Files (x86)\ossec-agent\ossec.conf
```

```xml
<localfile>
  <location>Microsoft-Windows-Sysmon/Operational</location>
  <log_format>eventchannel</log_format>
</localfile>
```

After confirming the configuration, the Wazuh Agent service was restarted on the Windows endpoint:

```powershell
Restart-Service WazuhSvc
```

The service status was verified:

```powershell
Get-Service WazuhSvc
```

---

## Final Custom Detection Rules

The final custom rules used child-rule logic with `<if_sid>` because several events were already being matched by Wazuh built-in rules before the original standalone custom rules matched.

```xml
<group name="windows,sysmon,phase15,detection_engineering,">

  <rule id="100200" level="12">
    <if_sid>92057</if_sid>
    <description>Phase 15 - Custom detection: Encoded PowerShell command detected on Windows endpoint</description>
    <mitre>
      <id>T1059.001</id>
    </mitre>
  </rule>

  <rule id="100201" level="10">
    <if_sid>92036</if_sid>
    <field name="win.eventdata.commandLine" type="pcre2">(?i)\bnet\s+user\b</field>
    <description>Phase 15 - Custom detection: Local user enumeration command detected</description>
    <mitre>
      <id>T1087.001</id>
    </mitre>
  </rule>

  <rule id="100202" level="10">
    <if_sid>92036</if_sid>
    <field name="win.eventdata.commandLine" type="pcre2">(?i)\bnet\s+localgroup\s+administrators\b</field>
    <description>Phase 15 - Custom detection: Local administrators group enumeration detected</description>
    <mitre>
      <id>T1069.001</id>
    </mitre>
  </rule>

  <rule id="100203" level="10">
    <if_sid>92032</if_sid>
    <field name="win.eventdata.commandLine" type="pcre2">(?i)\bschtasks\b</field>
    <description>Phase 15 - Custom detection: Scheduled task command execution detected</description>
    <mitre>
      <id>T1053.005</id>
    </mitre>
  </rule>

  <rule id="100204" level="10">
    <if_sid>60122</if_sid>
    <description>Phase 15 - Custom detection: Windows failed logon event detected</description>
    <mitre>
      <id>T1110</id>
    </mitre>
  </rule>

</group>
```

---

## Custom Rule Mapping

| Custom Rule ID | Parent Rule ID | Detection | Log Source | MITRE ATT&CK |
|---|---:|---|---|---|
| 100200 | 92057 | Encoded PowerShell command | Sysmon Event ID 1 | T1059.001 |
| 100201 | 92036 | Local user enumeration using `net user` | Sysmon Event ID 1 | T1087.001 |
| 100202 | 92036 | Local administrators group enumeration | Sysmon Event ID 1 | T1069.001 |
| 100203 | 92032 | Scheduled task command execution | Sysmon Event ID 1 | T1053.005 |
| 100204 | 60122 | Windows failed logon event | Security Event ID 4625 | T1110 |

---

## Rule Validation Commands

### Rule 100200 - Encoded PowerShell

Command executed on `SOC-Windows11-01`:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -EncodedCommand VwByAGkAdABlAC0ATwB1AHQAcAB1AHQAIAAiAFAASABBAFMARQAxADUAXwBFAE4AQwBPAEQARQBEAF8AQwBPAE0ATQBBAE4ARABfAFQARQBTAFQAIgA=
```

Validation on Wazuh Server:

```bash
sudo tail -n 300 /var/ossec/logs/alerts/alerts.json | jq -r '
select(.agent.name=="SOC-Windows11-01")
| select(.rule.id=="100200")
| {
  timestamp: .timestamp,
  rule_id: .rule.id,
  description: .rule.description,
  provider: .data.win.system.providerName,
  channel: .data.win.system.channel,
  eventID: .data.win.system.eventID,
  commandLine: .data.win.eventdata.commandLine
}'
```

Result:

```text
Rule ID 100200 triggered successfully.
```

---

### Rule 100201 - Local User Enumeration

Command executed on `SOC-Windows11-01`:

```powershell
cmd.exe /c net user
```

Validation on Wazuh Server:

```bash
sudo tail -n 1000 /var/ossec/logs/alerts/alerts.json | jq -r '
select(.agent.name=="SOC-Windows11-01")
| select(.rule.id=="100201")
| {
  timestamp: .timestamp,
  rule_id: .rule.id,
  description: .rule.description,
  provider: .data.win.system.providerName,
  channel: .data.win.system.channel,
  eventID: .data.win.system.eventID,
  commandLine: .data.win.eventdata.commandLine
}'
```

Result:

```text
Rule ID 100201 triggered successfully.
```

---

### Rule 100202 - Local Administrators Group Enumeration

Command executed on `SOC-Windows11-01`:

```powershell
cmd.exe /c "net localgroup administrators"
```

Validation on Wazuh Server:

```bash
sudo tail -n 1000 /var/ossec/logs/alerts/alerts.json | jq -r '
select(.agent.name=="SOC-Windows11-01")
| select(.rule.id=="100202")
| {
  timestamp: .timestamp,
  rule_id: .rule.id,
  description: .rule.description,
  provider: .data.win.system.providerName,
  channel: .data.win.system.channel,
  eventID: .data.win.system.eventID,
  commandLine: .data.win.eventdata.commandLine
}'
```

Result:

```text
Rule ID 100202 triggered successfully.
```

---

### Rule 100203 - Scheduled Task Command Execution

Command executed on `SOC-Windows11-01`:

```powershell
cmd.exe /c schtasks /query
```

Validation on Wazuh Server:

```bash
sudo tail -n 1000 /var/ossec/logs/alerts/alerts.json | jq -r '
select(.agent.name=="SOC-Windows11-01")
| select(.rule.id=="100203")
| {
  timestamp: .timestamp,
  rule_id: .rule.id,
  description: .rule.description,
  provider: .data.win.system.providerName,
  channel: .data.win.system.channel,
  eventID: .data.win.system.eventID,
  commandLine: .data.win.eventdata.commandLine
}'
```

Result:

```text
Rule ID 100203 triggered successfully.
```

---

### Rule 100204 - Windows Failed Logon

Command executed on `SOC-Windows11-01`:

```powershell
runas /user:%COMPUTERNAME%\fakeuser cmd
```

An incorrect password was entered to generate a failed logon event.

Windows local verification:

```powershell
Get-WinEvent -FilterHashtable @{
  LogName='Security'
  Id=4625
  StartTime=(Get-Date).AddMinutes(-10)
} | Select-Object -First 5 TimeCreated,Id,ProviderName,Message | Format-List
```

Validation on Wazuh Server:

```bash
sudo tail -n 3000 /var/ossec/logs/alerts/alerts.json | jq -r '
select(.agent.name=="SOC-Windows11-01")
| select(.rule.id=="100204")
| {
  timestamp: .timestamp,
  rule_id: .rule.id,
  description: .rule.description,
  provider: .data.win.system.providerName,
  channel: .data.win.system.channel,
  eventID: .data.win.system.eventID,
  targetUserName: .data.win.eventdata.targetUserName,
  status: .data.win.eventdata.status
}'
```

Result:

```text
Rule ID 100204 triggered successfully.
```

---

## Troubleshooting Summary

During validation, several rules initially did not trigger.

The root cause was that Wazuh built-in rules were already matching the events before the custom standalone rules matched.

Examples:

| Event | Built-in Rule Observed | Fix |
|---|---:|---|
| Encoded PowerShell | 92057 | Converted 100200 to child rule using `<if_sid>92057</if_sid>` |
| `net user` | 92036 | Converted 100201 to child rule using `<if_sid>92036</if_sid>` |
| `net localgroup administrators` | 92036 | Converted 100202 to child rule using `<if_sid>92036</if_sid>` |
| `schtasks` | 92032 | Converted 100203 to child rule using `<if_sid>92032</if_sid>` |
| Failed logon 4625 | 60122 | Converted 100204 to child rule using `<if_sid>60122</if_sid>` |

Another issue was command-line spacing. Some Windows command lines appeared as:

```text
net  user
schtasks  /query
```

Because of this, PCRE2 expressions using `\s+` were used to match one or more spaces.

Example:

```xml
<field name="win.eventdata.commandLine" type="pcre2">(?i)\bnet\s+user\b</field>
```

---

## Dashboard Validation

Each custom rule was validated in Wazuh Dashboard using the following queries:

```text
rule.id:100200
rule.id:100201
rule.id:100202
rule.id:100203
rule.id:100204
```

The time range was set to:

```text
Last 1 hour
```

or:

```text
Last 24 hours
```

---

## Screenshots

The following screenshots were captured to validate the Phase 15 custom detection rules in Wazuh Dashboard.

### Rule 100200 - Encoded PowerShell Detection

![Phase 15 Rule 100200 Detected](../screenshots/30-phase15-rule100200-detected.png)

This screenshot shows the Wazuh Dashboard alert for custom rule `100200`, which detects encoded PowerShell command execution from Sysmon Event ID 1.

---

### Rule 100201 - Local User Enumeration Detection

![Phase 15 Rule 100201 Detected](../screenshots/31-phase15-rule100201-detected.png)

This screenshot shows the Wazuh Dashboard alert for custom rule `100201`, which detects local user enumeration using the `net user` command.

---

### Rule 100202 - Local Administrators Group Enumeration Detection

![Phase 15 Rule 100202 Detected](../screenshots/32-phase15-rule100202-detected.png)

This screenshot shows the Wazuh Dashboard alert for custom rule `100202`, which detects local administrators group enumeration using the `net localgroup administrators` command.

---

### Rule 100203 - Scheduled Task Command Detection

![Phase 15 Rule 100203 Detected](../screenshots/33-phase15-rule100203-detected.png)

This screenshot shows the Wazuh Dashboard alert for custom rule `100203`, which detects scheduled task command execution using `schtasks`.

---

### Rule 100204 - Windows Failed Logon Detection

![Phase 15 Rule 100204 Detected](../screenshots/34-phase15-rule100204-detected.png)

This screenshot shows the Wazuh Dashboard alert for custom rule `100204`, which detects Windows failed logon events from Security Event ID 4625.

---

## Final Results

All Phase 15 custom detection rules were successfully validated.

| Rule ID | Detection | Status |
|---:|---|:---:|
| 100200 | Encoded PowerShell command | Completed |
| 100201 | Local user enumeration | Completed |
| 100202 | Local administrators group enumeration | Completed |
| 100203 | Scheduled task command execution | Completed |
| 100204 | Windows failed logon | Completed |

---

## Skills Demonstrated

This phase demonstrated the following SOC and detection engineering skills:

- Windows endpoint telemetry collection
- Sysmon log collection
- Windows Security Event log analysis
- Wazuh custom rule creation
- Wazuh child-rule logic using `<if_sid>`
- PCRE2 command-line matching
- MITRE ATT&CK mapping
- Alert validation using CLI and Dashboard
- Detection troubleshooting
- SIEM rule tuning and verification

---

## Phase 15 Completion Statement

Phase 15 was completed successfully.

The Enterprise SOC Home Lab now includes validated custom detection engineering content for Windows endpoint activity, including PowerShell abuse, account discovery, group enumeration, scheduled task execution, and failed logon detection.

This completes the detection engineering and final validation phase of the SOC home lab project.
