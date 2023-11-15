domain=win11
iso_path=~/.uni/os/driver/virtio-win-0.1.240.iso

attach_iso_to_vm() {
    if [ $# -ne 2 ]; then
        echo "Usage: attach_iso_to_vm <domain-name> <iso-path>"
        return 1
    fi

    local domain_name=$1
    local iso_path=$2

    # Check if the VM is running
    if ! sudo virsh list --all --name | grep -q "$domain_name"; then
        echo "Error: Virtual machine '$domain_name' is not running."
        return 1
    fi

    # Attach the ISO to the VM
    sudo virsh attach-disk "$domain_name" "$iso_path" hdc --type cdrom --mode readonly

    echo "ISO attached successfully to '$domain_name'."
}

attach_iso_to_vm $domain $iso_path
