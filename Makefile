.PHONY: build clean deploy gomodgen

include .env

build: 
	cat .env
	yarn install
	yarn build

clean:
	rm -rf ./dist

deploy: clean build test
	ansible-playbook playbook_create.yml -e "bucket_name=$(BUCKET_NAME)"
	@echo "Frontend Deployed to http://$(BUCKET_NAME).s3-website-$(shell aws s3api get-bucket-location --bucket $(BUCKET_NAME) --output text).amazonaws.com"

test:
	yarn test

delete:
	ansible-playbook playbook_delete.yml -e "bucket_name=$(BUCKET_NAME)"
