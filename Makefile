.PHONY: install uninstall

DESTDIR ?=
PREFIX ?= /usr

all:
	@echo Nothing to do

install:
	@install -Dm755 prem "$(DESTDIR)$(PREFIX)/bin/prem"
	@install -Dm755 prem-setup "$(DESTDIR)$(PREFIX)/bin/prem-setup"
	@install -Dm644 prem.example.conf \
	  "$(DESTDIR)$(PREFIX)/share/prem/prem.example.conf"

uninstall:
	@rm -rf "${PREFIX}/bin/prem"{,-setup} "${PREFIX}/share/prem"
