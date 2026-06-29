# Phase 11 - Wazuh Server Installation

## Objective

Deploy Wazuh All-in-One on the Ubuntu Server virtual machine and verify that the Wazuh Dashboard is accessible from the lab network.

This phase installs and validates the main Wazuh server components:

* Wazuh Indexer
* Wazuh Manager
* Wazuh Dashboard
* Filebeat

After this phase, the lab is ready for endpoint agent deployment and centralized log collection.

---

# Environment Overview

| Item | Configuration |
| ---- | ------------- |
| Virtual Machine | SOC-Ubuntu-Server-01 |
| Platform | VMware Workstation Pro |
| Operating System | Ubuntu Server |
| Deployment Type | Wazuh All-in-One |
| Wazuh Version | 4.14 |
| CPU | 4 vCPU |
| Memory | 8 GB RAM |
| Network | Internal SOC LAN |
| Dashboard Access | HTTPS |
| Default Dashboard Port | 443 |

---

# Step 1 - Prepare the Ubuntu Server VM

Before installing Wazuh, the Ubuntu Server VM was adjusted to provide enough resources for an All-in-One deployment.

The final VM configuration was:

```text
CPU: 4 vCPU
Memory: 8 GB RAM
Disk: 60 GB
