# VMware Workstation Pro Installation

## Project

Enterprise SOC Home Lab

---

## Objective

Prepare the virtualization environment for building a mini enterprise SOC lab.

---

## Host Machine

| Item | Specification |
|------|---------------|
| OS | Windows 11 Pro |
| CPU | AMD Ryzen 7 7730U |
| RAM | 32 GB |
| Storage | 500 GB SSD |
| VMware | VMware Workstation Pro 17 |

---

## VMware Installation

### Download

Downloaded VMware Workstation Pro 17.

---

### Installation Notes

Because Windows 11 uses Virtualization Based Security (VBS), VMware detected Hyper-V support.

Selected:

- Install Windows Hypervisor Platform automatically

VMware installed successfully.

---

## VMware Preferences

### Default VM Folder

```

C:\CyberLab\VMware

```

### ISO Folder

```

C:\CyberLab\ISO

```

---

## Virtual Networks

Configured using Virtual Network Editor.

### VMnet8

Purpose:

NAT

Used for Internet access.

### VMnet1

Purpose:

Host-only

Used for the internal enterprise LAN.

### VMnet0

Bridge

Kept as default.

---

## Notes

### Windows Security Configuration

During VMware installation, Virtualization-based Security (VBS) was detected.

Memory Integrity was temporarily disabled to avoid potential compatibility issues during the initial lab setup.

VMware Workstation Pro was installed using the Windows Hypervisor Platform (WHP) compatibility mode.

This configuration will be reviewed again after the lab environment is fully deployed.

---

## Screenshots

Screenshots are stored in:

```

screenshots/

```

---

## Status

Completed

Next Step:

Create pfSense Firewall virtual machine.
