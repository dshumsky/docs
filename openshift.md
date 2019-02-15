##### Minishift

- https://github.com/dhiltgen/docker-machine-kvm#quick-start-instructions
```bash
sudo curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.7.0/docker-machine-driver-kvm -o /usr/local/bin/docker-machine-driver-kvm
sudo chmod +x /usr/local/bin/docker-machine-driver-kvm

sudo apt install libvirt-bin qemu-kvm
sudo usermod -a -G libvirtd <username>
newgrp libvirtd
```
- reboot
- `minishift start/stop`
- https://docs.openshift.org/latest/minishift/using/index.html
- `export PATH="~/.minishift/cache/oc/v3.7.1/linux:$PATH"`

- Create new application: https://docs.openshift.org/latest/dev_guide/application_lifecycle/new_app.html

