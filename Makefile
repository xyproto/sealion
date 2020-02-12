.PHONY: install uninstall

.DEFAULT_TARGET := install

DESTDIR ?=
PREFIX ?= /usr

install:
	./prem-install "${DESTDIR}" "${PREFIX}"

uninstall:
	rm -f "${PREFIX}/bin/prem"
	rm -f "${PREFIX}/share/prem/time.conf"
	rmdir "${PREFIX}/share/prem"
