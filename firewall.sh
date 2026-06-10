# create new zone to which we will add rules for the TS interface
sudo firewall-cmd --permanent --new-zone=tailscale
sudo firewall-cmd --reload

# probably tailscale0 was put in public by default, move it to its own zone that we manage separately
sudo firewall-cmd --permanent --zone=public --remove-interface=tailscale0
sudo firewall-cmd --permanent --zone=tailscale --add-interface=tailscale0

# boom drop all traffic
sudo firewall-cmd --permanent --zone=tailscale --set-target=DROP

# but allow ssh, though you can disable it with `sudo tailscale set --ssh=false`
sudo firewall-cmd --permanent --zone=tailscale --add-service=ssh
sudo firewall-cmd --reload
