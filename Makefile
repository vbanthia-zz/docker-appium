.DEFAULT_GOAL := all

TAG ?= 'latest'

.PHONY: all
all:
	$(MAKE) build-all
	$(MAKE) push-all

.PHONY: build-base
build-base:
	docker build -t vbanthia/appium-base:$(TAG) ./appium-base/

.PHONY: build-ruby
build-ruby:
	docker build -t vbanthia/appium-ruby:$(TAG) ./appium-ruby/

.PHONY: build-stf
build-stf:
	docker build -t vbanthia/appium-stf:$(TAG) ./appium-stf

.PHONY: push-base
push-base:
	docker push vbanthia/appium-base:$(TAG)

.PHONY: push-ruby
push-ruby:
	docker push vbanthia/appium-ruby:$(TAG)

.PHONY: push-stf
push-stf:
	docker push vbanthia/appium-stf:$(TAG)

.PHONY: build-all
build-all:
	$(MAKE) build-base
	$(MAKE) build-ruby
	$(MAKE) build-stf

.PHONY: push-all
push-all:
	$(MAKE) push-base
	$(MAKE) push-ruby
	$(MAKE) push-stf
