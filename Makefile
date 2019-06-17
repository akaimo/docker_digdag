up:
	docker-compose build
	docker-compose up -d

down:
	docker-compose down

build:
	docker build .

digdag:
	docker exec -it digdag bash

push:
	docker exec -it digdag bash -c 'cd /workflows && digdag push sample'
