up:
	docker-compose up

down:
	docker-compose down

build:
	docker-compose build

shell:
	docker-compose run --rm -p "9000:3000" offerkarma bash
