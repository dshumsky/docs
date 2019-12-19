export CURRENT_UID=$(id -u):$(id -g)
echo $CURRENT_UID
docker-compose --compatibility up -d
