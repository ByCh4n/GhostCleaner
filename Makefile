ROOT	= ""
PREFIX	= $(ROOT)/usr
BINDIR	= $(PREFOX)/bin

install:
	install -m 755 ./GhostCleaner.sh $(BINDIR)/ghostcleaner

uninstall:
	rm -f $(BINDIR)/ghostcleaner

reinstall:
	rm -f $(BINDIR)/ghostcleaner
	install -m 755 ./GhostCleaner.sh $(BINDIR)/ghostcleaner