DESTDIR ?=
BINDIR ?= /usr/local/bin
SYSTEMDUNITDIR ?= /usr/local/lib/systemd/system

all:
	@ echo "Use: make install, make uninstall"

install:
	install -d $(DESTDIR)$(BINDIR)

	install -m0755 mglru $(DESTDIR)$(BINDIR)/mglru
	install -m0755 set_mglru $(DESTDIR)$(BINDIR)/set_mglru
	install -m0755 set_min_ttl_ms $(DESTDIR)$(BINDIR)/set_min_ttl_ms

	-install -d $(DESTDIR)$(SYSTEMDUNITDIR)
	-sed "s|:TARGET_BIN:|$(BINDIR)|g" mglru.service.in > mglru.service
	-install -m0644 mglru.service $(DESTDIR)$(SYSTEMDUNITDIR)/mglru.service
	-chcon -t systemd_unit_file_t $(DESTDIR)$(SYSTEMDUNITDIR)/mglru.service
	-rm -fv mglru.service
	# Very nice!

uninstall:
	-systemctl disable mglru.service || :

	rm -fv $(DESTDIR)$(BINDIR)/mglru
	rm -fv $(DESTDIR)$(BINDIR)/set_mglru
	rm -fv $(DESTDIR)$(BINDIR)/set_min_ttl_ms

	-rm -fv $(DESTDIR)$(SYSTEMDUNITDIR)/mglru.service

	-systemctl daemon-reload
