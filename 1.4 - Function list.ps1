# Preparation:
    # Add VMware and Veeam PowerShell modules
    # Check running in elevated PowerShell window
    # Connect to vCenter and Veeam Backup Server 
# Checks:
    # Get information about the vSphere VM guest hostname
    # Check guest credentials
    # Ensure UAC is disabled in guest
    # Check OS at least Server 2008 R2
    # Determine whether to convert to Gen2 VM or not (Server 2012 and later only)
    # Check Hyper-V VM with same name doesn't already exist
    # Check if VM requires a reboot
# Prepare VM for migration:
    # Copy Veeam to the VM using Copy-VMGuestFile (VMware)
    # Install Veeam, assign license and configure backup using Invoke-VMScript
    # Enable Remote PowerShell using Invoke-VMScript
# Collect VM information:
    # vSphere VM networking: Port group name, VLAN, MAC Address, IP Address, Subnet mask, DNS servers, static routes
    # Check for applications that don't support Dynamic Memory in Hyper-V e.g. Exchange
# Migration:
    # Start Veeam Agent for Windows Backup
    # Rescan Veeam server repository and wait till restore point found
    # Select latest restore point (!)
    # Shut down vSphere VM
    # Start Instant Restore into Hyper-V and wait for completion
    # Convert to Gen2 VM if needed
# SCVMM prep:
    # Create new Cloud in SCVMM based on VMware VM folder name
    # Assign permissions to the Cloud for the support team
    # Create Network Sites (VLAN/subnet)
    # Add Network Sites to Uplink Port Profile for host
    # Create a new VM Network for the Network Site
# Hyper-V VM prep:
    # Set VM memory (no Dynamic Memory for Exchange)
    # Set CPU count
    # Connect all NICs to the correct VM Networks
    # Make VM highly available on Hyper-V cluster
# Complete Hyper-V VM migration:
    # Power up Hyper-V VM on routable temporary network with DHCP assigned address
    # Find MAC address from SCVMM and use this to get IP from DHCP server
    # Connect with Remote PowerShell and set IPs, DNS and static routes on other NICs
    # Uninstall VMware tools
    # Uninstall Veeam Agent for Windows
    # Remove temporary NIC
    # Migrate to production storage.
