# Enterprise SOC Home Lab

A hands-on Enterprise Security Operations Center (SOC) Home Lab built with VMware Workstation Pro.

This project simulates a real enterprise environment to gain practical experience with firewall deployment, endpoint security, centralized logging, threat detection, and SOC operations.

---

# Project Objectives

* Build an enterprise-style virtual network
* Deploy a pfSense perimeter firewall
* Secure Windows and Linux endpoints
* Collect and centralize security logs
* Implement SIEM and endpoint monitoring
* Simulate cyber attacks and validate detections
* Document every deployment step using GitHub

---

# Current Project Status

| Phase                          |    Status   |
| ------------------------------ | :---------: |
| Host Preparation               | ✅ Completed |
| VMware Installation            | ✅ Completed |
| pfSense Firewall Deployment    | ✅ Completed |
| Windows 11 Endpoint Deployment | ✅ Completed |
| VMware Tools Installation      |  ⏳ Planned  |
| Ubuntu Server Deployment       |  ⏳ Planned  |
| Kali Linux Deployment          |  ⏳ Planned  |
| Wazuh SIEM                     |  ⏳ Planned  |
| Elastic Stack                  |  ⏳ Planned  |
| Sysmon Deployment              |  ⏳ Planned  |
| Detection Engineering          |  ⏳ Planned  |

---

# Current Enterprise Network

```text
                        Internet
                            │
                      Home Router
                            │
                     VMware VMnet8
                         (NAT)
                            │
                      WAN (em0)
                    ┌──────────────┐
                    │   pfSense    │
                    │   Firewall   │
                    └──────────────┘
                      LAN (em1)
                            │
                    VMware VMnet1
                      (Host-only)
                            │
                    ┌────────────────┐
                    │ SOC-Windows11-01 │
                    └────────────────┘

                 (Additional systems will be added)

                • Ubuntu Server
                • Kali Linux
                • Wazuh SIEM
                • Elastic Stack
```

---

# Completed Infrastructure

## VMware Workstation Pro

* VMware Workstation Pro 17 installed
* Enterprise virtual networking configured
* VMnet0 (Bridged)
* VMnet1 (Host-only)
* VMnet8 (NAT)

---

## pfSense Firewall

Successfully deployed:

* pfSense CE 2.8.1
* WAN / LAN architecture
* DHCP configuration
* Enterprise network segmentation
* Internal LAN deployment

---

## Windows Endpoint

Successfully deployed:

* Windows 11 Pro
* UEFI Firmware
* Secure Boot
* Virtual TPM
* Enterprise virtual hardware
* Connected to VMnet1

---

# Repository Structure

```text
enterprise-soc-home-lab
│
├── README.md
│
├── docs
│   ├── 01-host-preparation.md
│   ├── 02-vmware-installation.md
│   ├── 03-pfsense-installation.md
│   └── 04-windows11-installation.md
│
├── screenshots
│   ├── vmware
│   ├── pfsense
│   └── windows11
│
├── diagrams
│
├── configs
│
└── scripts
```

---

# Documentation

| Document                     | Description                                                     |
| ---------------------------- | --------------------------------------------------------------- |
| 01-host-preparation.md       | Prepare the Windows host for virtualization                     |
| 02-vmware-installation.md    | Install VMware Workstation Pro and configure virtual networking |
| 03-pfsense-installation.md   | Deploy pfSense CE and configure WAN/LAN interfaces              |
| 04-windows11-installation.md | Deploy the first enterprise Windows endpoint                    |

---

# Technologies

* VMware Workstation Pro
* pfSense CE
* Windows 11 Pro
* UEFI
* Secure Boot
* TPM 2.0
* Virtual Networking

---

# Skills Demonstrated

* Enterprise Virtualization
* Enterprise Firewall Deployment
* Windows Endpoint Deployment
* Network Segmentation
* DHCP Configuration
* VMware Virtual Networking
* Infrastructure Documentation
* Technical Troubleshooting

---

# Upcoming Milestones

The next phase of the project will focus on endpoint hardening and log collection.

Planned activities:

* Install VMware Tools
* Configure Windows networking
* Verify Internet connectivity through pfSense
* Install Windows Updates
* Install Sysmon
* Enable PowerShell logging
* Deploy Ubuntu Server
* Install Wazuh Agent
* Build centralized log collection

---

# Project Goal

The final objective is to build a complete Enterprise SOC Home Lab consisting of:

* pfSense Firewall
* Windows 11 Endpoint
* Ubuntu Server
* Kali Linux
* Wazuh SIEM
* Elastic Stack
* Sysmon
* MITRE ATT&CK Detection Rules

This project is intended to demonstrate practical cybersecurity skills through hands-on implementation, documentation, and continuous improvement.

---

# Author

Enterprise SOC Home Lab

Built as a hands-on cybersecurity portfolio project.

