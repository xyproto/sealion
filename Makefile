.PHONY: install uninstall

PREFIX ?= /usr
.DEFAULT_TARGET := install

install:
	./prem-install "${PREFIX}"

uninstall:
	rm -f "${PREFIX}/bin/prem"
	rm -f "${PREFIX}/share/prem/time.conf"
	rmdir "${PREFIX}/share/prem"
