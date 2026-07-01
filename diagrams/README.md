# Diagrams

This folder contains architecture and data flow diagrams for the Enterprise SOC Home Lab.

The diagrams provide a visual overview of the lab network design, virtual machine layout, log forwarding path, and Wazuh detection workflow.

---

## Diagram Files

| File | Description |
|---|---|
| `enterprise-soc-home-lab-network-diagram.png` | Overall network topology of the SOC home lab |
| `enterprise-soc-home-lab-network-diagram.drawio` | Editable draw.io source file for the network topology diagram |
| `wazuh-log-flow-diagram.png` | Wazuh log collection, forwarding, analysis, and alerting flow |
| `wazuh-log-flow-diagram.drawio` | Editable draw.io source file for the Wazuh log flow diagram |

---

## Enterprise SOC Home Lab Network Diagram

![Enterprise SOC Home Lab Network Diagram](enterprise-soc-home-lab-network-diagram.png)

This diagram shows the overall virtual lab architecture.

It includes:

- Host computer running VMware Workstation Pro
- pfSense firewall
- Internal SOC lab network
- Windows 11 endpoint
- Ubuntu Wazuh Server
- Kali Linux security testing workstation
- Wazuh Agent log forwarding path
- Host browser access to Wazuh Dashboard

---

## Wazuh Log Flow Diagram

![Wazuh Log Flow Diagram](wazuh-log-flow-diagram.png)

This diagram shows the log collection and detection flow.

It includes:

- Sysmon Event ID 1 process creation logs
- Windows Security Event ID 4625 failed logon logs
- Wazuh Agent log collection
- Log forwarding to the Wazuh Server over TCP 1514
- Wazuh Manager and Analysisd processing
- Custom detection rules
- Wazuh Indexer storage
- Wazuh Dashboard validation
- Phase 15 custom alerts

---

## Phase 15 Detection Workflow

The Wazuh log flow diagram supports the Phase 15 detection engineering documentation.

Phase 15 custom rules validated:

| Rule ID | Detection | Log Source | MITRE ATT&CK |
|---:|---|---|---|
| 100200 | Encoded PowerShell command | Sysmon Event ID 1 | T1059.001 |
| 100201 | Local user enumeration using `net user` | Sysmon Event ID 1 | T1087.001 |
| 100202 | Local administrators group enumeration | Sysmon Event ID 1 | T1069.001 |
| 100203 | Scheduled task command execution using `schtasks` | Sysmon Event ID 1 | T1053.005 |
| 100204 | Windows failed logon event | Security Event ID 4625 | T1110 |

Full Phase 15 documentation:

[../docs/15-detection-engineering-final-documentation.md](../docs/15-detection-engineering-final-documentation.md)

---

## How to Edit the Diagrams

The `.drawio` files are editable source files.

To edit them:

1. Open [draw.io / diagrams.net](https://app.diagrams.net/)
2. Choose **Open Existing Diagram**
3. Select the `.drawio` file
4. Make changes
5. Export an updated `.png` version
6. Upload both the updated `.drawio` and `.png` files back to this folder

---

## How to Reference These Diagrams

From the main `README.md`:

```markdown
![Enterprise SOC Home Lab Network Diagram](diagrams/enterprise-soc-home-lab-network-diagram.png)

![Wazuh Log Flow Diagram](diagrams/wazuh-log-flow-diagram.png)
```

From files inside the `docs/` folder:

```markdown
![Enterprise SOC Home Lab Network Diagram](../diagrams/enterprise-soc-home-lab-network-diagram.png)

![Wazuh Log Flow Diagram](../diagrams/wazuh-log-flow-diagram.png)
```

---

## Purpose

These diagrams make the project easier to understand for readers reviewing the GitHub repository.

They help explain:

- How the virtual SOC lab is structured
- How network segmentation is handled
- How endpoint logs are collected
- How logs are forwarded into Wazuh
- How Wazuh custom detections generate alerts
- How Phase 15 detection engineering was validated
