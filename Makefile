GO := $(shell which go)
GO_VERSION := $(shell $(GO) version)
 
GOLANG_ANNOT_ROOT := $(shell echo "${HOME}/github.com/Duxxie/golangAnnotations")

all: gen test install

help:
	@echo "\tdeps: installs all dependencies"
	@echo "\tgen: generates boilerplate code"
	@echo "\ttest: Run all tests"

deps:
	@echo "---------------------------"
	@echo "Install relevant dependencies"
	@echo "---------------------------"
	go mod download
	go install golang.org/x/tools/cmd/goimports

generate:
	@echo "----------------------"
	@echo "Generating source-code"
	@echo "----------------------"
	make install
	$(GO) generate ./...

imports:
	@echo "------------------"
	@echo "Optimizing imports"
	@echo "------------------"
	find . -name '*.go' -exec goimports -l -w -local github.com/ {} \;

format: imports
	@echo "----------------------"
	@echo "Formatting source-code"
	@echo "----------------------"
	find . -name '*.go' -exec gofmt -l -s -w {} \;

gen: generate imports format

check:
	@echo "---------------------"
	@echo "Perform static analysis"
	@echo "---------------------"
	$(GO) vet ./...

test: clean check
	@echo "---------------------"
	@echo "Running backend tests"
	@echo "---------------------"
	$(GO) test ./...                        # run unit tests
	make format

citest:
	@echo "---------------------"
	@echo "Running backend tests"
	@echo "---------------------"
	make install
	$(GO) generate -tags ci  ./...
	make imports
	$(GO) test -tags ci ./...                        # run unit tests
	make format

coverage:
	@echo "----------------"
	@echo "Running coverage"
	@echo "----------------"
	$(GOLANG_ANNOT_ROOT)/scripts/coverage.sh --html

clean:
	find . -name 'gen_*.go' -exec rm -rfv {} +
	rm -rf ./examples/rest/restTestLog/ ./generator/rest/testData/ ./generator/event/testDataStore/
	$(GO) clean ./...

install: clean
	@echo "----------------------------"
	@echo "Installing for $(GO_VERSION)"
	@echo "----------------------------"
	$(GO) install ./...

.PHONY:
	help deps gen check test citest coverage install clean all
