.PHONY: all clean minified server watch help

HUGO := ~/.bin/hugo
#HTML_MINIFIER := html-minifier -c html-minifier.conf

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

watch:
	$(HUGO) server -w --verbose --cleanDestinationDir --enableGitInfo --buildDrafts --buildFuture \
		--destination public/
build:
	$(HUGO) server --verbose --minify --cleanDestinationDir --enableGitInfo \
		--destination public/

#minified: .minified
# .minified: public html-minifier.conf
# 	# Find all HTML and in parallel run the minifier
# 	#find public -type f -iname '*.html' | parallel --tag $(HTML_MINIFIER) "{}" -o "{}"
# 	#touch .minified
