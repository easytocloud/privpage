HOMEBREW_PREFIX ?= /usr/local

install:
	(cd distribution/bin ; cp privpage whoiam $(HOMEBREW_PREFIX)/bin)
