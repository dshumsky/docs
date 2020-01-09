.PHONY:

up:
	docker network create my || true
	docker-compose --compatibility up -d --build
down:
	docker-compose down
