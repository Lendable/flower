REGISTRY=177947534298.dkr.ecr.eu-west-1.amazonaws.com
IMAGE=flower
TAG:=$(shell git rev-parse HEAD)
PUSH_TAG:=$(TAG)

docker.build:
	docker build -t "flower:$(TAG)" .

docker.publish:
	docker tag "flower:$(TAG)" "$(REGISTRY)/$(IMAGE):$(PUSH_TAG)"
	docker push "$(REGISTRY)/$(IMAGE):$(PUSH_TAG)"

