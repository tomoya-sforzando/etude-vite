# -*- coding: utf-8 -*-

CMD_DOCKER := docker
CMD_DOCKER_COMPOSE := docker-compose
CONTAINER_APP := app

.PHONY: ps up shell logs follow hide reveal build start lint test generate deploy down clean prune help

ps: ## 監視
	$(CMD_DOCKER_COMPOSE) ps

up: ## 起動
	$(CMD_DOCKER_COMPOSE) up ${ARGS} --detach --remove-orphans

shell: up ## 接続
	$(CMD_DOCKER_COMPOSE) exec ${ARGS} $(CONTAINER_APP) /bin/ash

logs: ## 記録
	$(CMD_DOCKER_COMPOSE) logs ${ARGS} --timestamp

follow: ## 追跡
	$(CMD_DOCKER_COMPOSE) logs ${ARGS} --timestamp --follow

hide: ## 秘匿
	git secret hide -v

reveal: ## 暴露
	git secret reveal -v

# build: up
# 	$(CMD_DOCKER_COMPOSE) exec ${ARGS} $(CONTAINER_APP) yarn build

# start: build
# 	$(CMD_DOCKER_COMPOSE) exec ${ARGS} --detach $(CONTAINER_APP) yarn start

# lint: up
# 	$(CMD_DOCKER_COMPOSE) exec ${ARGS} $(CONTAINER_APP) yarn lint

# test: up
# 	$(CMD_DOCKER_COMPOSE) exec ${ARGS} $(CONTAINER_APP) yarn test

# generate: up
# 	$(CMD_DOCKER_COMPOSE) exec ${ARGS} $(CONTAINER_APP) yarn generate

# deploy: generate
# 	echo "TODO: Not Implemented Yet!"

down: ## 停止
	$(CMD_DOCKER_COMPOSE) down ${ARGS} --rmi all --remove-orphans

clean: down ## 掃除
	rm -rf log/*

prune: down ## 破滅
	$(CMD_DOCKER) system prune ${ARGS} --all --force --volumes

help: ## 助言
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
