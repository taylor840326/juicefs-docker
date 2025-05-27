IMAGE := ghcr.io/wutz/juicefs
TAG   := 1.2-reef
DOCKER_FILE := Dockerfile.ubuntu
.PHONY: all
all:
	@echo "make image or push"

.PHONY: image
image:
	docker build \
		-t $(IMAGE):$(TAG) \
		-t $(IMAGE):latest \
		.

.PHONY: squid-ubuntu-2004
squid-ubuntu-2004:
	sed -i -e 's/22.04/20.04/g' $(DOCKER_FILE)
	docker build \
		--build-arg "https_proxy=http://Clash:pHSyKiPM@172.18.3.199:7890" \
		-t $(IMAGE):$(TAG) \
		-t $(IMAGE):latest \
		-f $(DOCKER_FILE) \
		.
	sed -i -e 's/20.04/22.04/g' $(DOCKER_FILE)

.PHONY: squid-ubuntu-2204
squid-ubuntu-2204:
	docker build \
		--build-arg "https_proxy=http://Clash:pHSyKiPM@172.18.3.199:7890" \
		-t $(IMAGE):$(TAG) \
		-t $(IMAGE):latest \
		-f $(DOCKER_FILE) \
		.

.PHONY: squid-ubuntu-2404
squid-ubuntu-2404:
	sed -i -e 's/22.04/24.04/g' $(DOCKER_FILE)
	docker build \
		--build-arg "https_proxy=http://Clash:pHSyKiPM@172.18.3.199:7890" \
		-t $(IMAGE):$(TAG) \
		-t $(IMAGE):latest \
		-f $(DOCKER_FILE) \
		.
	sed -i -e 's/24.04/22.04/g' $(DOCKER_FILE)



.PHONY: push
push: image
	docker push \
		$(IMAGE):$(TAG)
	docker push \
		$(IMAGE):latest
