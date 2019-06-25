##### Docker
- `docker inspect $(sudo docker ps -aq) | less` - inspect all
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
