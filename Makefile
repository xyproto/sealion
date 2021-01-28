.PHONY: install uninstall

DESTDIR ?=
PREFIX ?= /usr

all:
	@echo Nothing to do

install:
	@install -Dm755 sealion "$(DESTDIR)$(PREFIX)/bin/sealion"
	@install -Dm755 sealion-setup "$(DESTDIR)$(PREFIX)/bin/sealion-setup"
	@install -Dm644 sealion.example.conf \
	  "$(DESTDIR)$(PREFIX)/share/sealion/sealion.example.conf"

uninstall:
	@rm -rf "${PREFIX}/bin/sealion"{,-setup} "${PREFIX}/share/sealion"
