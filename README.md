# Enterprise SOC Home Lab

A professional Security Operations Center (SOC) home lab built with VMware Workstation Pro, pfSense, Windows, Linux, Sysmon, Wazuh, and Elastic Stack.

The objective of this project is to simulate a small enterprise environment and gain hands-on experience in network security, endpoint monitoring, log management, threat detection, and SOC operations.

---

# Project Status

| Phase                       |     Status    |
| --------------------------- | :-----------: |
| Host Preparation            |  ✅ Completed  |
| VMware Installation         |  ✅ Completed  |
| pfSense Firewall Deployment |  ✅ Completed  |
| Windows Endpoint            | ⏳ In Progress |
| Ubuntu Server               |   ⏳ Planned   |
| Wazuh SIEM                  |   ⏳ Planned   |
| Elastic Stack               |   ⏳ Planned   |
| Attack Simulation           |   ⏳ Planned   |
| Detection Engineering       |   ⏳ Planned   |

---

# Current Lab Architecture

```text
                     Internet
                         │
                    Home Router
                         │
                    VMware NAT
                     (VMnet8)
                         │
                    WAN (em0)
                 ┌──────────────┐
                 │   pfSense    │
                 │  Firewall    │
                 └──────────────┘
                    LAN (em1)
                  VMnet1 (LAN)
                         │
      ┌──────────┬──────────┬──────────┬──────────┐
      │Windows11 │ Ubuntu   │ Kali     │ Wazuh    │
      └──────────┴──────────┴──────────┴──────────┘
```

---

# Completed Components

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
* Dual-NIC firewall architecture
* WAN (DHCP)
* LAN network
* DHCP Server
* Enterprise network segmentation

---

# Documentation

| Document                   | Description                                               |
| -------------------------- | --------------------------------------------------------- |
| 01-host-preparation.md     | Windows host preparation and virtualization configuration |
| 02-vmware-installation.md  | VMware Workstation installation and virtual networking    |
| 03-pfsense-installation.md | pfSense CE installation and WAN/LAN configuration         |

---

# Technologies

* VMware Workstation Pro
* pfSense CE
* Windows 11
* Ubuntu Server
* Kali Linux
* Sysmon
* Wazuh
* Elastic Stack
* MITRE ATT&CK

---

# Skills Demonstrated

* Virtualization
* Enterprise Network Design
* Firewall Deployment
* Network Segmentation
* DHCP Configuration
* Virtual Networking
* Cybersecurity Documentation
* Troubleshooting

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
│   └── 03-pfsense-installation.md
│
├── screenshots
│   ├── vmware
│   └── pfsense
│
├── diagrams
│
├── configs
│
└── scripts
```

---

# Next Milestone

The next phase of this project is to deploy the first Windows endpoint.

Planned virtual machine:

```text
SOC-Windows11-01
```

The Windows endpoint will:

* Join the internal LAN
* Receive DHCP configuration from pfSense
* Install Sysmon
* Generate Windows Event Logs
* Forward logs to the future SIEM environment

---

# Author

Cybersecurity Home Lab Project

Built for hands-on SOC Analyst training and portfolio development.
