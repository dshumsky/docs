#### Configuration
- delete network link `sudo ip link del docker0`
- `sudo ip link add name docker0 type bridge && sudo ip addr add dev docker0 172.17.0.1/16`
- modify `daemon.json`:
- DNS <https://development.robinwinslow.uk/2016/06/23/fix-docker-networking-dns/>
    - `nslookup <some-site>` to get `DNS SERVER`
    - Add `"dns": ["<DNS SERVER>"]` to `/etc/docker/daemon.json`
    - `sudo service docker restart`

#### Usage

- `docker inspect $(docker ps -aq) | less` - inspect all
- start a container
    - `docker run --rm -it alpine:latest sh`
    - `docker run --rm alpine:latest tail -f /dev/null`
- `host.docker.internal` - resolves to the internal IP address used by the host
- access host:
    - ```
      extra_hosts:
      - host.docker.internal:10.36.1.55
      ```
- Fix route after VPN    `sudo route add -net 172.17.0.0 netmask 255.255.0.0 dev docker0`
- fix vim `echo "export TERM=xterm" >> ~/.bashrc`
- Oracle       `d run --net=host --shm-size=2g alexeiled/docker-oracle-xe-11g:sshd`
- Disconnect   `Ctrl-p + Ctrl-q`
- Build && Run `d build -t foo . && docker run -it foo`
- Wait command `tail -f /dev/null`
- Clean
    - `docker rmi $(docker images --format '{{.ID}}' --filter=dangling=true)`
    - `docker volume rm $(docker volume ls -f dangling=true -q)`
    - `docker images -a | grep "pattern" | awk '{print $3}' | xargs docker rmi`

##### ./bashrc
```
function dstart() {
  sudo ip link add name docker0 type bridge && sudo ip addr add dev docker0 172.17.0.1/16
  sudo service docker start
}

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
  docker network prune -f
}
```
