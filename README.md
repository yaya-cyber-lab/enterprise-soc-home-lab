# Enterprise SOC Home Lab

## Project Overview

This project documents the build of a mini enterprise SOC home lab using VMware Workstation Pro, pfSense firewall, Windows and Linux virtual machines, Sysmon logging, and SIEM-based detection.

The goal of this lab is to simulate a small enterprise network and practice hands-on cybersecurity skills, including network segmentation, firewall configuration, endpoint logging, SIEM ingestion, attack simulation, and detection engineering.

## Lab Objectives

- Build a virtual enterprise-style network using VMware Workstation Pro
- Deploy pfSense as the network firewall
- Create an isolated internal LAN for security testing
- Deploy Windows and Linux endpoints
- Collect endpoint and system logs
- Install and configure Sysmon
- Forward logs into a SIEM platform
- Create basic detection rules mapped to MITRE ATT&CK
- Document each step with screenshots and validation results

## Current Status

| Phase | Status |
|---|---|
| Host preparation | Completed |
| VMware Workstation installation | Completed |
| VMware network planning | In progress |
| pfSense firewall setup | Not started |
| Windows client setup | Not started |
| Linux server setup | Not started |
| SIEM setup | Not started |
| Detection rules | Not started |

## Lab Environment

| Component | Details |
|---|---|
| Host OS | Windows 11 Pro |
| Virtualization | VMware Workstation Pro 17.6.4 |
| RAM | 32 GB |
| Disk | 500 GB SSD |
| Firewall | pfSense |
| Endpoints | Windows, Ubuntu, Kali Linux |
| SIEM | Wazuh / Elastic |

## Planned Network Topology

```text
Internet
   |
Home Router
   |
VMware NAT Network
   |
pfSense WAN
   |
pfSense Firewall
   |
VMware Host-Only LAN
   |
Windows Client / Ubuntu Server / Kali / SIEM
