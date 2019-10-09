IMAGE_NAME=sam-github-actions
BATS_TESTS=$(wildcard *.bats */*.bats)

.PHONY: build
build: docker build -t $(IMAGE_NAME) .

.PHONY: docker-tag
docker-tag:
	tag $(IMAGE_NAME) $(DOCKER_REPO)/$(IMAGE_NAME) --no-latest

.PHONY: docker-publish
docker-publish: docker-tag ## Publish the image and tags to a repository.
	docker push $(DOCKER_REPO)/$(IMAGE_NAME)

.PHONY: test
test:
	bats $(BATS_TESTS)
