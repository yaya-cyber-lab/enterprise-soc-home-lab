# Enterprise SOC Home Lab

A hands-on Enterprise Security Operations Center (SOC) Home Lab built with VMware Workstation Pro.

This project simulates a small enterprise network environment to gain practical experience with virtualization, firewall deployment, network segmentation, endpoint deployment, Linux administration, centralized logging, SIEM preparation, threat detection, and SOC operations.

---

# Project Objectives

* Build an enterprise-style virtual network
* Deploy a pfSense perimeter firewall
* Configure isolated internal lab networks
* Deploy Windows and Linux endpoints
* Prepare Ubuntu Server for future SIEM deployment
* Enable endpoint logging and remote administration
* Collect and centralize security logs
* Deploy SIEM and endpoint monitoring tools
* Simulate cyber attacks and validate detections
* Document every deployment step using GitHub

---

# Current Project Status

| Phase    | Description                                   |    Status   |
| -------- | --------------------------------------------- | :---------: |
| Phase 01 | Host Preparation                              | ✅ Completed |
| Phase 02 | VMware Workstation Installation               | ✅ Completed |
| Phase 03 | pfSense Firewall Deployment                   | ✅ Completed |
| Phase 04 | Windows 11 Endpoint Deployment                | ✅ Completed |
| Phase 05 | Windows Endpoint Updates and Tools            | ✅ Completed |
| Phase 06 | Windows Endpoint Logging Preparation          | ✅ Completed |
| Phase 07 | Kali Linux Deployment                         | ✅ Completed |
| Phase 08 | Ubuntu Server Deployment                      | ✅ Completed |
| Phase 09 | Lab Network Stabilization                     | ✅ Completed |
| Phase 10 | Ubuntu Server Preparation for SIEM            | ✅ Completed |
| Phase 11 | Wazuh Server Installation                     |  ⏳ Planned  |
| Phase 12 | Wazuh Agent Deployment                        |  ⏳ Planned  |
| Phase 13 | Sysmon Deployment                             |  ⏳ Planned  |
| Phase 14 | Attack Simulation and Detection Validation    |  ⏳ Planned  |
| Phase 15 | Detection Engineering and Final Documentation |  ⏳ Planned  |

---

# Current Enterprise Network

```text
                        Internet
                            │
                      Home Router
                            │
                    Bridged Network
                            │
                       WAN (em0)
                    ┌──────────────┐
                    │   pfSense    │
                    │   Firewall   │
                    └──────────────┘
                       LAN (em1)
                            │
                    VMware Host-only
                    192.168.10.0/24
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
┌────────────────┐  ┌────────────────┐  ┌──────────────────────┐
│ SOC-Windows11  │  │ SOC-Kali       │  │ SOC-Ubuntu-Server    │
│ Endpoint       │  │ Attack Box     │  │ Future SIEM Server   │
└────────────────┘  └────────────────┘  └──────────────────────┘
        │                   │                   │
  Windows Logs       Attack Simulation     Wazuh / SIEM
  Sysmon Logs        Security Testing      Log Collection
```

---

# Network Design

The lab uses pfSense as the main firewall and gateway for the internal SOC network.

| Component           | Network Role                                     |
| ------------------- | ------------------------------------------------ |
| pfSense WAN         | Connected to the home network using Bridged mode |
| pfSense LAN         | Internal SOC lab gateway                         |
| Internal Network    | 192.168.10.0/24                                  |
| Internal Gateway    | 192.168.10.1                                     |
| Windows 11 Endpoint | Internal enterprise workstation                  |
| Kali Linux          | Attack simulation and security testing system    |
| Ubuntu Server       | Future SIEM / Wazuh server                       |

---

# Known Network Decision

During lab testing, pfSense WAN was tested with VMware VMnet8 NAT. Although pfSense WAN received a DHCP address from VMnet8, internal lab hosts were unable to access the Internet through pfSense.

When pfSense WAN was changed to Bridged mode, Windows 11, Kali Linux, and Ubuntu Server were able to access the Internet successfully through the pfSense LAN gateway.

To keep the project moving forward, Bridged mode was selected as the stable working WAN configuration. VMnet8 NAT troubleshooting is documented as a future improvement item.

---

# Completed Infrastructure

## VMware Workstation Pro

Successfully completed:

* VMware Workstation Pro installed
* Lab VM storage structure created
* Virtual networking reviewed and configured
* Bridged networking used for pfSense WAN
* Host-only networking used for the internal SOC LAN
* Multiple virtual machines deployed for the lab environment

---

## pfSense Firewall

Successfully deployed:

* pfSense CE firewall
* WAN / LAN interface architecture
* LAN gateway configuration
* DHCP service for internal lab hosts
* Internal network segmentation
* Internet access for internal lab systems through pfSense
* Stable Bridged WAN configuration selected

---

## Windows 11 Endpoint

Successfully deployed and prepared:

* Windows 11 Pro virtual machine
* UEFI firmware
* Secure Boot
* Virtual TPM
* Enterprise-style workstation configuration
* Network connectivity through pfSense LAN
* Windows updates completed
* Endpoint logging preparation completed

---

## Kali Linux

Successfully deployed:

* Kali Linux virtual machine
* Internal SOC lab network connectivity
* Internet connectivity through pfSense
* Prepared as the attack simulation and security testing system

---

## Ubuntu Server

Successfully deployed and prepared:

* Ubuntu Server virtual machine
* Hostname configured as `soc-ubuntu-server-01`
* Network connectivity verified
* Internet access verified through pfSense
* Base administration tools installed
* SSH service enabled
* Prepared as the future SIEM / Wazuh server

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
│   ├── 04-windows11-endpoint-deployment.md
│   ├── 05-windows-endpoint-updates-and-tools.md
│   ├── 06-windows-endpoint-logging-preparation.md
│   ├── 07-kali-linux-deployment.md
│   ├── 08-ubuntu-server-deployment.md
│   ├── 09-lab-network-stabilization.md
│   └── 10-ubuntu-server-siem-preparation.md
│
├── screenshots
│   ├── vmware
│   ├── pfsense
│   ├── windows11
│   ├── kali-linux
│   ├── ubuntu-server
│   ├── phase09-network-stabilization
│   └── phase10-ubuntu-siem-preparation
│
├── diagrams
│
├── configs
│
└── scripts
```

---

# Documentation

| Document                                   | Description                                                     |
| ------------------------------------------ | --------------------------------------------------------------- |
| 01-host-preparation.md                     | Prepare the Windows host for virtualization                     |
| 02-vmware-installation.md                  | Install VMware Workstation Pro and configure virtual networking |
| 03-pfsense-installation.md                 | Deploy pfSense CE and configure WAN/LAN interfaces              |
| 04-windows11-endpoint-deployment.md        | Deploy the first enterprise Windows endpoint                    |
| 05-windows-endpoint-updates-and-tools.md   | Install updates and required tools on the Windows endpoint      |
| 06-windows-endpoint-logging-preparation.md | Prepare Windows endpoint logging for future SOC monitoring      |
| 07-kali-linux-deployment.md                | Deploy Kali Linux for attack simulation and security testing    |
| 08-ubuntu-server-deployment.md             | Deploy Ubuntu Server as the future SIEM server                  |
| 09-lab-network-stabilization.md            | Stabilize the lab network and verify Internet connectivity      |
| 10-ubuntu-server-siem-preparation.md       | Prepare Ubuntu Server for future SIEM / Wazuh installation      |

---

# Technologies Used

* VMware Workstation Pro
* pfSense CE
* Windows 11 Pro
* Ubuntu Server
* Kali Linux
* UEFI
* Secure Boot
* TPM 2.0
* Linux command line
* PowerShell
* SSH
* Netplan
* Virtual networking
* Network segmentation

---

# Skills Demonstrated

* Enterprise virtualization
* Firewall deployment
* pfSense WAN / LAN configuration
* Network segmentation
* DHCP configuration
* Windows endpoint deployment
* Linux server deployment
* Kali Linux deployment
* SSH administration
* Linux package management
* Ubuntu server preparation
* Network troubleshooting
* DNS and HTTPS connectivity testing
* Technical decision making
* GitHub portfolio documentation

---

# Upcoming Milestones

The next major milestone is SIEM deployment.

Planned activities:

* Install Wazuh Server on Ubuntu
* Access the Wazuh dashboard
* Deploy Wazuh agent on Windows 11
* Deploy Wazuh agent on Ubuntu Server
* Deploy Wazuh agent on Kali Linux if needed
* Install and configure Sysmon on Windows
* Forward Windows security logs
* Generate test security events
* Simulate basic attacker activity from Kali Linux
* Validate alerts in the SIEM dashboard
* Map detections to MITRE ATT&CK techniques

---

# Next Phase

```text
Phase 11 - Install Wazuh Server on Ubuntu
```

The Ubuntu Server has been prepared as the future SIEM server. The next step is to install Wazuh and begin centralized security monitoring for the Enterprise SOC Home Lab.

---

# Final Project Goal

The final objective is to build a complete Enterprise SOC Home Lab consisting of:

* pfSense Firewall
* Windows 11 Endpoint
* Ubuntu Server
* Kali Linux
* Wazuh SIEM
* Sysmon
* Centralized log collection
* Security alerts
* MITRE ATT&CK detection mapping
* Attack simulation and detection validation

This project is intended to demonstrate practical cybersecurity skills through hands-on implementation, troubleshooting, documentation, and continuous improvement.

---

# Author

Enterprise SOC Home Lab

Built as a hands-on cybersecurity portfolio project.
