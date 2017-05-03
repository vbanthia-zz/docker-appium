.PHONY: build-all
TAG ?= 'latest'

.PHONY: build-base
build-base:
	docker build -t vbanthia/appium-base:$(TAG) ./appium-base/

.PHONY: build-ruby
build-ruby:
	docker build -t vbanthia/appium-ruby:$(TAG) ./appium-ruby/

.PHONY: build-ruby-onbuild
build-ruby-onbuild:
	docker build -t vbanthia/appium-ruby-onbuild:$(TAG) ./appium-ruby/onbuild/

.PHONY: build-stf
build-stf:
	docker build -t vbanthia/appium-stf:$(TAG) ./appium-stf

.PHONY: build-all
build-all: build-base build-ruby build-ruby-onbuild build-stf

.PHONY: push-base
push-base:
	docker push vbanthia/appium-base:$(TAG)

.PHONY: push-ruby
push-ruby:
	docker push vbanthia/appium-ruby:$(TAG)

.PHONY: push-ruby-onbuild
push-ruby-onbuild:
	docker push vbanthia/appium-ruby-onbuild:$(TAG)

.PHONY: push-stf
push-stf:
	docker push vbanthia/appium-stf:$(TAG)

.PHONY: push-all
	push-all: push-base push-ruby push-ruby-onbuild push-stf
