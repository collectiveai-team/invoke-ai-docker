include .env
export $(shell sed 's/=.*//' .env)


build:
	docker compose build invoke-ai-core

run:
	docker compose run invoke-ai-gpu

run-cpu:
	docker compose run invoke-ai-cpu
