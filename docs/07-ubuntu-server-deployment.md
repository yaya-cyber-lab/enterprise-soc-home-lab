# Ubuntu Server Deployment

## Objective

Deploy an Ubuntu Server virtual machine as a Linux endpoint in the Enterprise SOC Home Lab.

This Ubuntu Server will be used for future SOC lab components, including:

* Linux endpoint logging
* SSH administration
* Network validation
* Wazuh agent testing
* Elastic / SIEM integration
* Attack simulation and detection testing

---

## Lab Environment

| Item                 | Configuration              |
| -------------------- | -------------------------- |
| Virtual Machine Name | SOC-Ubuntu-Server-01       |
| Operating System     | Ubuntu Server 24.04.4 LTS  |
| Hostname             | soc-ubuntu-server-01       |
| Username             | socadmin                   |
| Platform             | VMware Workstation Pro     |
| CPU                  | 2 virtual cores            |
| Memory               | 2 GB / 4 GB                |
| Disk                 | 40 GB                      |
| Network              | VMnet1 / SOC LAN           |
| IP Address           | 192.168.10.102             |
| Default Gateway      | pfSense LAN - 192.168.10.1 |
| SSH                  | Enabled                    |

---

## Network Design

The Ubuntu Server was deployed inside the internal SOC network behind the pfSense firewall.

```text
Internet
   |
Windows Host
   |
VMware NAT / Bridged WAN
   |
pfSense Firewall
   |-- WAN
   |-- LAN: 192.168.10.1/24
            |
            |-- Windows 11 Endpoint
            |-- Ubuntu Server: 192.168.10.102
```

This design allows the Ubuntu Server to operate as an internal Linux endpoint while all outbound traffic passes through pfSense.

---

## Step 1: Download Ubuntu Server ISO

Ubuntu Server 24.04.4 LTS ISO was downloaded and saved to the local ISO directory.

```text
C:\CyberLab\ISO
```

ISO file name:

```text
ubuntu-server-24.04.iso
```

![Ubuntu Server ISO Downloaded](../screenshots/ubuntu/19-phase7-ubuntu-iso-downloaded.png)

**Figure 19: Ubuntu Server 24.04 LTS ISO downloaded**

---

## Step 2: Create Ubuntu Server Virtual Machine

A new virtual machine was created in VMware Workstation.

Virtual machine name:

```text
SOC-Ubuntu-Server-01
```

Virtual machine path:

```text
C:\CyberLab\VMware\SOC-Ubuntu-Server-01
```

The VM was configured with:

* 2 virtual CPU cores
* 40 GB virtual disk
* VMnet1 internal SOC LAN network
* Ubuntu Server 24.04 LTS ISO attached

![Ubuntu VM Created](../screenshots/ubuntu/20-phase7-ubuntu-vm-created.png)

**Figure 20: Ubuntu Server VM created in VMware Workstation**

---

## Step 3: Configure Virtual Disk

The Ubuntu Server virtual disk was configured with a 40 GB maximum capacity.

The disk was stored as multiple files to make the VM easier to move, copy, and back up during the lab build.

![Ubuntu Disk Capacity](../screenshots/ubuntu/21-phase7-ubuntu-disk-capacity.png)

**Figure 21: Ubuntu Server virtual disk configured**

---

## Step 4: Configure Network Adapter

The Ubuntu Server VM network adapter was connected to the SOC internal network.

```text
Network Adapter: Custom VMnet1
```

This allows Ubuntu Server to communicate with pfSense LAN and other internal SOC endpoints.

![Ubuntu Network Adapter](../screenshots/ubuntu/22-phase7-ubuntu-network-adapter-vmnet1.png)

**Figure 22: Ubuntu Server network adapter connected to VMnet1**

---

## Step 5: Install Ubuntu Server

Ubuntu Server installation was started from the ISO.

The following installation options were selected:

```text
Language: English
Keyboard: English (US)
Installation Type: Ubuntu Server
```

The server profile was configured as:

```text
Hostname: soc-ubuntu-server-01
Username: socadmin
```

OpenSSH Server was enabled during installation to support remote administration.

![Ubuntu Installation Started](../screenshots/ubuntu/23-phase7-ubuntu-installation-start.png)

**Figure 23: Ubuntu Server installation started**

![Ubuntu User Profile](../screenshots/ubuntu/24-phase7-ubuntu-user-profile.png)

**Figure 24: Ubuntu Server user profile configured**

![Ubuntu SSH Enabled](../screenshots/ubuntu/25-phase7-ubuntu-ssh-enabled.png)

**Figure 25: OpenSSH Server enabled during installation**

---

## Step 6: First Login Validation

After installation, the VM was rebooted and the first login was completed successfully.

The following commands were used for validation:

```bash
hostname
whoami
ip a
lsb_release -a
```

Validation results:

```text
Hostname: soc-ubuntu-server-01
User: socadmin
OS: Ubuntu 24.04.4 LTS
```

![Ubuntu First Login](../screenshots/ubuntu/26-phase7-ubuntu-first-login.png)

**Figure 26: Ubuntu Server first login completed**

---

## Step 7: Network Troubleshooting and IP Address Validation

Initially, the Ubuntu Server network interface was detected but did not receive an IPv4 address.

The interface was identified as:

```text
ens33
```

A netplan DHCP configuration was created for the interface:

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    ens33:
      dhcp4: true
```

The configuration was applied with:

```bash
sudo chmod 600 /etc/netplan/01-ens33-dhcp.yaml
sudo netplan generate
sudo netplan apply
```

After correction, the Ubuntu Server successfully received an IP address from the SOC LAN DHCP service.

```text
IP Address: 192.168.10.102/24
Interface: ens33
Gateway: 192.168.10.1
```

![Ubuntu IP Address](../screenshots/ubuntu/27-phase7-ubuntu-ip-address.png)

**Figure 27: Ubuntu Server received SOC LAN IP address**

---

## Step 8: Network Connectivity Test

Internal and external network connectivity were tested.

The following commands were used:

```bash
ping -c 4 192.168.10.1
ping -c 4 8.8.8.8
ping -c 4 google.com
```

Validation results:

| Test                     | Result     |
| ------------------------ | ---------- |
| Ping pfSense LAN gateway | Successful |
| Ping external IP address | Successful |
| DNS resolution test      | Successful |

![Ubuntu Network Test](../screenshots/ubuntu/28-phase7-ubuntu-network-test.png)

**Figure 28: Ubuntu Server network connectivity validated**

---

## Step 9: System Update

The Ubuntu Server package index was updated and available upgrades were installed.

```bash
sudo apt update
sudo apt upgrade -y
```

Basic administration and troubleshooting tools were installed:

```bash
sudo apt install -y net-tools curl wget vim git unzip htop tree openssh-server
```

![Ubuntu System Update](../screenshots/ubuntu/29-phase7-ubuntu-system-update.png)

**Figure 29: Ubuntu Server system update completed**

---

## Step 10: SSH Service Validation

The SSH service was checked after installation.

```bash
sudo systemctl status ssh
```

The service showed active running status.

```text
SSH Status: active running
```

![Ubuntu SSH Status](../screenshots/ubuntu/30-phase7-ubuntu-ssh-status.png)

**Figure 30: Ubuntu Server SSH service active**

---

## Final Validation

The Ubuntu Server deployment was completed successfully.

| Validation Item           | Status    |
| ------------------------- | --------- |
| Ubuntu Server installed   | Completed |
| Hostname configured       | Completed |
| SOC LAN IP assigned       | Completed |
| pfSense LAN reachable     | Completed |
| Internet access validated | Completed |
| DNS resolution validated  | Completed |
| System updated            | Completed |
| Basic tools installed     | Completed |
| SSH enabled and active    | Completed |

---

## Result

Ubuntu Server was successfully deployed as a Linux endpoint inside the Enterprise SOC Home Lab.

The VM is ready for future phases, including:

* Kali Linux deployment
* Wazuh SIEM deployment
* Linux log forwarding
* Elastic Stack integration
* Detection engineering
* Attack simulation and event collection
