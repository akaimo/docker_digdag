up:
	docker-compose build
	docker-compose up -d

down:
	docker-compose down

build:
	docker build .

digdag:
	docker exec -it digdag bash
