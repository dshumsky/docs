docker network create my || true
mkdir -p data
export CURRENT_UID=$(id -u):$(id -g)
docker-compose up -d
