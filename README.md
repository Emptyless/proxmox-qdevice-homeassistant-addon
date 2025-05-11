# Proxmox QDevice External Vote Support HomeAssistant Add-on

> ⚠️ this is experimental and not recommended for production usage, use at own risk ⚠️

This add-on wraps the [corosync external vote support](https://pve.proxmox.com/wiki/Cluster_Manager#_corosync_external_vote_support)
feature of Proxmox in a Home Assistant add-on. This can be useful if you have a dedicated Home Assistant device and an even amount
of nodes for Proxmox.

## Getting Started

See [Corosync External Vote Support](https://pve.proxmox.com/pve-docs/chapter-pvecm.html#_corosync_external_vote_support) for complete
setup details. Below is a summary:

1) Enable port 22 of the plugin such that SSH is (temporarily) enabled by setting its value to '22'

> ⚠️ SSH port 22 must be used during the setup process if following the steps below as it is a requirement of the [QDevice setup](https://pve.proxmox.com/pve-docs/pvecm.1.html#_requirements) tool ⚠️

2) On each node of the Proxmox cluster install `corosync-qdevice`:

```
apt install corosync-qdevice
```

3) Install the HomeAssistant Corosync Add-on

4) Add the public key to the Add-on configuration

_by default this can be found on a Proxmox node using:_
```
cat ~/.ssh/id_rsa.pub
```

This will give you something like:
```yaml
...
public_keys:
  - public_key: "ssh-<type> <key>"
...
```

5) Start the Add-on

6) On a node from which the public key is added to the configuration, add the QDevice:

```
pvecm qdevice setup <IP of HomeAssistant device>
```

7) Verify the quorum and that the Add-on is voting

```
pvecm status
```

8) Disable the SSH port (for security reasons) by clearing it's value


9) Verify the quorum and that the Add-on is voting on a Proxmox node

```
pvecm status
```

## Removing QDevice

To remove the QDevice from the quorum (e.g. when adding a new node to the cluster), run on some Proxmox node:

```
pvecm qdevice remove
```