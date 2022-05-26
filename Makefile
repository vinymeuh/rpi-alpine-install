.DEFAULT_GOAL := help
.PHONY: pitwo pizerow

pitwo: ## Build for pitwo
	rm -rf build
	mkdir -p build
	cd pitwo &&  tar czf ../build/pitwo.apkovl.tar.gz etc
	[ -f wifi.txt ] && cp wifi.txt build

pizerow: ## Build for pizerow
	rm -rf build
	mkdir -p build
	cd pizerow &&  tar czf ../build/pizerow.apkovl.tar.gz etc
	cp pizerow/cmdline.txt build
	cp pizerow/usercfg.txt build
	[ -f wifi.txt ] && cp wifi.txt build


help: ## Show Help
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@exit 0
