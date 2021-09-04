DESTDIR ?=
BINDIR ?= /usr/local/bin
SYSTEMDUNITDIR ?= /etc/systemd/system

all:
	@ echo "Use: make install, make uninstall"

install:
	install -d $(DESTDIR)$(BINDIR)

	install -m0755 mglru $(DESTDIR)$(BINDIR)/mglru
	install -m0755 mglru0 $(DESTDIR)$(BINDIR)/mglru0
	install -m0755 mglru1 $(DESTDIR)$(BINDIR)/mglru1
	install -m0755 min_ttl_ms $(DESTDIR)$(BINDIR)/min_ttl_ms
	install -m0755 set_min_ttl_ms $(DESTDIR)$(BINDIR)/set_min_ttl_ms

	-install -d $(DESTDIR)$(SYSTEMDUNITDIR)
	-sed "s|:TARGET_BIN:|$(BINDIR)|g" mglru0.service.in > mglru0.service
	-sed "s|:TARGET_BIN:|$(BINDIR)|g" mglru1.service.in > mglru1.service

	-install -m0644 mglru0.service $(DESTDIR)$(SYSTEMDUNITDIR)/mglru0.service
	-install -m0644 mglru1.service $(DESTDIR)$(SYSTEMDUNITDIR)/mglru1.service

	-chcon -t systemd_unit_file_t $(DESTDIR)$(SYSTEMDUNITDIR)/mglru0.service
	-chcon -t systemd_unit_file_t $(DESTDIR)$(SYSTEMDUNITDIR)/mglru1.service

	-rm -fv mglru0.service
	-rm -fv mglru1.service

uninstall:
	-systemctl disable mglru0.service || :
	-systemctl disable mglru1.service || :

	rm -fv $(DESTDIR)$(BINDIR)/mglru
	rm -fv $(DESTDIR)$(BINDIR)/mglru0
	rm -fv $(DESTDIR)$(BINDIR)/mglru1
	rm -fv $(DESTDIR)$(BINDIR)/min_ttl_ms
	rm -fv $(DESTDIR)$(BINDIR)/set_min_ttl_ms

	-rm -fv $(DESTDIR)$(SYSTEMDUNITDIR)/mglru0.service
	-rm -fv $(DESTDIR)$(SYSTEMDUNITDIR)/mglru1.service

	-systemctl daemon-reload
