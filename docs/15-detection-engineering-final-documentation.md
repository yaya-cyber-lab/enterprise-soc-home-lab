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
