cat <<EOF > /usr/local/sbin/mount-shared-folders
#!/bin/sh
vmware-hgfsclient | while read folder; do
  vmwpath="/mnt/hgfs/\${folder}"
  echo "[i] Mounting \${folder}   (\${vmwpath})"
  sudo mkdir -p "\${vmwpath}"
  sudo umount -f "\${vmwpath}" 2>/dev/null
  sudo vmhgfs-fuse -o allow_other -o auto_unmount ".host:/\${folder}" "\${vmwpath}"
done
sleep 2s
EOF
sudo chmod +x /usr/local/sbin/mount-shared-folders


cat <<EOF > /usr/local/sbin/restart-vm-tools
#!/bin/sh
systemctl stop run-vmblock\\\\x2dfuse.mount
sudo killall -q -w vmtoolsd
systemctl start run-vmblock\\\\x2dfuse.mount
systemctl enable run-vmblock\\\\x2dfuse.mount
sudo vmware-user-suid-wrapper vmtoolsd -n vmusr 2>/dev/null
sudo vmtoolsd -b /var/run/vmroot 2>/dev/null
EOF
sudo chmod +x /usr/local/sbin/restart-vm-tools
ln -sf /usr/local/sbin/restart-vm-tools ~/Desktop/restart-vm-tools

