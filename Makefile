HUGO := ~/.bin/hugo_extended_0.100.2
DESTDIR=public
HUGO_VERSION=0.58.3
OPTIMIZE = find $(DESTDIR) -not -path "*/static/*" \( -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' \) -print0 | \
xargs -0 -P8 -n2 mogrify -strip -thumbnail '1000>'

# All input files
FILES=$(shell find content layouts static themes -type f)

# Below are PHONY targets
all: serve

help:
	@echo "Usage: make <command>"
	@echo "  all     Builds the blog and minifies it"
	@echo "  clean   Cleans all build files"
	@echo "  server  Runs a webserver on port 1313 to test the final minified result"
	@echo "  watch   Runs hugo in watch mode, waiting for changes"
	@echo ""
	@echo "New article:"
	@echo "  hugo new post/the_title"
	@echo "  $$EDITOR content/post/the_title.md"
	@echo "  make watch"
	@echo "  open "


.PHONY: all
all: clean watch

.PHONY: clean
clean:
	@echo "🧹 Cleaning old build"
	cd $(DESTDIR) && rm -rf *

.PHONY: version
version:
	$(HUGO) version

.PHONY: watch
watch:
	$(HUGO) server -w --verbose --cleanDestinationDir  --enableGitInfo --buildDrafts --buildFuture \
		--destination public/
#

.PHONY: build
build:
	$(HUGO)           --verbose --cleanDestinationDir --enableGitInfo
		--minify \
		--destination public/

##

new:
	$(HUGO) new --enableGitInfo --kind blog --contentDir content \
		"blog/$(shell date +"%Y-%m-%d")-$(shell bash -c 'read -p "Slug (e.g., 'my-new-post'): " slug; echo $$slug').md"

# For a Github-pages workflow config, see https://github.com/marketplace/actions/proof-html
.PHONY: html-test
html-test: clean build
	docker run --rm -it -v $(pwd):/$(DESTDIR) klakegg/html-proofer:3.19.2 \
		--allow-hash-href --check-html --check_opengraph --check_favicon --check_img_http
