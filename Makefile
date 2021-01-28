include config.mk

all: init init.8 poweroff.8 reboot.8

%: %.in
	sed -e "s/#VERSION#/$(VERSION)/" $< > $@

init:
	$(CC) $(LDFLAGS) -o $@ init.c $(LDLIBS)

install: all
	install -Dm0755 init       $(DESTDIR)$(BINDIR)/init
	install -Dm0644 init.8     $(DESTDIR)$(MANDIR)/man8/init.8
	install -Dm0644 reboot.8   $(DESTDIR)$(MANDIR)/man8/reboot.8
	install -Dm0644 poweroff.8 $(DESTDIR)$(MANDIR)/man8/poweroff.8

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/init
	rm -f $(DESTDIR)$(MANDIR)/man8/init.8
	rm -f $(DESTDIR)$(MANDIR)/man8/reboot.8
	rm -f $(DESTDIR)$(MANDIR)/man8/poweroff.8

clean:
	rm -f init init.8 poweroff.8 reboot.8

.PHONY:
	all install uninstall clean
