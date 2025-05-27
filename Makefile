IMAGE := ghcr.io/wutz/juicefs
TAG   := 1.2
DOCKER_FILE := Dockerfile
.PHONY: all
all:
	@echo "make image or push"

.PHONY: image
image:
	docker build \
		-t $(IMAGE):$(TAG) \
		-t $(IMAGE):latest \
		.

.PHONY: ubuntu-20.04
ubuntu-20.04:
	sed -i -e 's/22.04/20.04/g' $(DOCKER_FILE)
	docker build \
		--build-arg "https_proxy=http://Clash:pHSyKiPM@172.18.3.199:7890" \
		-t $(IMAGE):$(TAG)-ubuntu-20.04 \
		-t $(IMAGE):latest \
		-f $(DOCKER_FILE).ubuntu \
		.
	sed -i -e 's/20.04/22.04/g' $(DOCKER_FILE)

.PHONY: ubuntu-22.04
ubuntu-22.04:
	docker build \
		--build-arg "https_proxy=http://Clash:pHSyKiPM@172.18.3.199:7890" \
		-t $(IMAGE):$(TAG)-ubuntu-22.04 \
		-t $(IMAGE):latest \
		-f $(DOCKER_FILE).ubuntu \
		.

.PHONY: ubuntu-24.04
ubuntu-24.04:
	sed -i -e 's/22.04/24.04/g' $(DOCKER_FILE)
	docker build \
		--build-arg "https_proxy=http://Clash:pHSyKiPM@172.18.3.199:7890" \
		-t $(IMAGE):$(TAG)-ubuntu-24.04 \
		-t $(IMAGE):latest \
		-f $(DOCKER_FILE).ubuntu \
		.
	sed -i -e 's/24.04/22.04/g' $(DOCKER_FILE)

.PHONY: rockylinux-8
rockylinux-8:
	docker build \
		--build-arg "https_proxy=http://Clash:pHSyKiPM@172.18.3.199:7890" \
		-t $(IMAGE):$(TAG)-rockylinux-8 \
		-t $(IMAGE):latest \
		-f $(DOCKER_FILE).rockylinux \
		.



.PHONY: push
push: image
	docker push \
		$(IMAGE):$(TAG)
	docker push \
		$(IMAGE):latest
