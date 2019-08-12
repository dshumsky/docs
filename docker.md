#### Configuration
- delete network link `sudo ip link del docker0`
- `sudo ip link add name docker0 type bridge && sudo ip addr add dev docker0 172.17.0.1/16`
- `daemon.json`:
    ```
    {
      "bip": "169.253.20.100/24",
      "fixed-cidr": "169.253.20.0/24",
      "default-address-pools":[
        {"base":"169.253.30.0/24","size":24}
      ],
      "insecure-registries": ["nexus.local:80"]
    }
    ```


#### Usage

- `docker inspect $(docker ps -aq) | less` - inspect all
- DNS https://development.robinwinslow.uk/2016/06/23/fix-docker-networking-dns/

| Feature                | Description                                                                        |
|----------------------- | -----------------------------------------------------------------------------------|
| Fix route after VPN    | sudo route add -net 172.17.0.0 netmask 255.255.0.0 dev docker0                     |
| start a container      | docker run --rm alpine:latest tail -f /dev/null                                    |
|                        | docker run --rm -it alpine:latest sh
| fix vim                | echo "export TERM=xterm" >> ~/.bashrc                                              |
| Oracle                 | d run --net=host --shm-size=2g alexeiled/docker-oracle-xe-11g:sshd                 |
| Disconnect             | Ctrl-p + Ctrl-q                                                                    |
| Build && Run           | d build -t foo . && docker run -it foo                                             |
| Wait command           | tail -f /dev/null                                                                  |
| Clean                  |                                                                                    |
| ... (images)           | docker rmi $(docker images --format '{{.ID}}' --filter=dangling=true)              |
| ... (volumes)          | docker volume rm $(docker volume ls -f dangling=true -q)                           |
|                        |                                                                                    |
|                        |                                                                                    |
|                        |                                                                                    |
|                        |                                                                                    |
|                        |                                                                                    |

##### ./bashrc
```
function dstop() {
  echo 'Stopping containers...'
  docker ps | grep "Up" | awk '{print $1}' | xargs --no-run-if-empty docker stop;
}

function drm() {
 echo 'Deleting containers...'
 docker ps --filter "status=exited" | grep "ago" | awk '{print $1}' | xargs --no-run-if-empty docker rm;
}

function dclean() {
  dstop;
  drm;
}
```
