#### SSH
- Enable SSH: `apt-get install openssh-server openssh-client`
- Remove password from SSH key: `openssl rsa -in ./key -out ./key-without-password`

#### sshd
Test config:
```
sudo sshd -T
sudo sshd -T -C user=ec2-user,host=server.com,addr=10.0.0.1
```

##### Bastion / JumpHost
Config:
```
Host dev-bastion
  HostName xx.xx.xx.xx
  User ec2-user
  Port 22
  IdentityFile ~/.ssh/dev-key

Host dev1
  HostName xx.xx.xx.xx
  User ec2-user
  IdentityFile ~/.ssh/dev-key
  ProxyJump dev-bastion
```

Runtime config:
```
ssh -o 'IdentityFile="dev-key"' \
  -o 'ProxyCommand=ssh -W %h:%p -q ec2-user@xx.xx.xx.xx' \
  ec2-user@xx.xx.xx.xx
```

Ansible config:
```yaml
all:
  children:
    dev:
      hosts:
        ec2-user@xx.xx.xx.xx:
          ansible_ssh_private_key_file: dev-key
          ansible_ssh_common_args: '-o ProxyCommand="ssh -W %h:%p -q ec2-user@xx.xx.xx.xx"'
```

#### Check Fingerprint of the SSH Key
```bash
ssh-keygen -l -f key.pub 
ssh-keygen -l -E md5 -f key.pub  (old)
ssh-keygen -l -f key
```