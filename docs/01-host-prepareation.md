# 01 - Host Preparation

## Objective

Prepare a Windows 11 host system for building a small enterprise Security Operations Center (SOC) home lab.

---

## Host Specifications

| Item       | Value                         |
| ---------- | ----------------------------- |
| Host OS    | Windows 11 Pro                |
| CPU        | AMD Ryzen 7 7730U             |
| Memory     | 32 GB RAM                     |
| Storage    | 500 GB SSD                    |
| Hypervisor | VMware Workstation Pro 17.6.4 |

---

## Preparation Tasks

* Verified BIOS virtualization support
* Installed VMware Workstation Pro 17.6.4
* Configured VMware global preferences
* Created enterprise project directory structure
* Planned enterprise virtual network
* Created GitHub repository

---

## Host Directory Structure

```text
C:\CyberLab
│
├── ISO
├── VMware
├── Documentation
├── GitHub
├── Snapshots
├── Exports
└── Scripts
```

---

## Lessons Learned

* VMware should be installed using the default program directory.
* Virtual machines should be stored outside the Documents folder.
* Enterprise environments separate application binaries from virtual machine data.
* Proper project documentation should begin before deploying virtual machines.

---

## Status

Completed
