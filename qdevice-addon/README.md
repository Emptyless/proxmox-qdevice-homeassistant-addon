# Proxmox QDevice External Vote Support Add-on

This Home Assistant add-on runs a `corosync-qnetd` server, allowing your Home Assistant device to act as a QDevice for Proxmox clusters. It helps maintain quorum in clusters with an even number of nodes.

## Features
- Runs `corosync-qnetd` for Proxmox QDevice support
- SSH access for secure setup (port 22, configurable)
- Supports multiple CPU architectures
- TLS and public key configuration

## Quick Start
1. **Install the add-on** in Home Assistant.
2. **Configure**:
	- Add your Proxmox node's public SSH key to the add-on config (`public_keys`).
	- Enable SSH port 22 during setup.
3. **Start the add-on**.
4. On a Proxmox node, run:
	```
	pvecm qdevice setup <HomeAssistant-IP>
	```
5. After setup, **disable SSH port 22** in the add-on config for security.

For advanced options, see the add-on configuration.

## Security
- Only enable SSH during setup. Disable it after configuration.
- Use strong public keys and review TLS settings.

## License
MIT
