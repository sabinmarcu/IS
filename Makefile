SOURCEDIR = src
BUILDDIR = lib
DOCDIR = docs

SOURCES := $(shell find $(SOURCEDIR) -name "*.coffee")

run: test minify documentation

source: $(BUILDDIR)/isf.js
minify: $(BUILDDIR)/isf.min.js
documentation: $(DOCDIR)/index.html

test: source ./node_modules/.bin
	node ./node_modules/.bin/mocha test/**/*.coffee test/*.coffee

$(BUILDDIR)/isf.js: $(SOURCES)
	node server --compile lib/isf.js

$(BUILDDIR)/isf.min.js: source ./node_modules/.bin
	node ./node_modules/.bin/uglifyjs lib/isf.js -o lib/isf.min.js

$(DOCDIR)/index.html: $(SOURCES) test
	./node_modules/.bin/codo --title 'ISF Documentation' -o docs src

./node_modules/.bin:
	npm install

clean:
	rm lib/isf.js
	rm lib/isf.min.js
	rm -rf docs/*
