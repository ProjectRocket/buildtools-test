DOCKER=docker
BUILDNAME=rocket/testbp
PROJECT=travis-docker-tests

.DEFAULT_GOAL=help

.PHONY: help

help:
	@echo "------------------------------------------------------------------------"
	@echo "$(PROJECT)"
	@echo "------------------------------------------------------------------------"
	@grep -E '^[a-zA-Z_/%\-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

docker: Dockerfile ## Build the docker image
	$(DOCKER) build -t $(BUILDNAME) .

docker-test: docker ## Run tests inside the container
	$(DOCKER) run -v $(HOME)/.ivy2:/root/.ivy2 -v $(HOME)/.sbt:/root/.sbt -it $(BUILDNAME) bash -c "sbt test"
