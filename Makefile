HOMEBREW_PREFIX ?= /usr/local

install:
	(cd distribution/bin ; cp * $(HOMEBREW_PREFIX)/bin)
