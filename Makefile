include config.mk

all: init init.8 poweroff.8 reboot.8

%: %.in
	sed -e "s/#VERSION#/$(VERSION)/" $< > $@

init:
	$(CC) $(LDFLAGS) -o $@ init.c $(LDLIBS)

install: all
	install -Dm0755 init        $(DESTDIR)$(PREFIX)/sbin/init
	install -Dm0755 reboot.sh   $(DESTDIR)$(PREFIX)/sbin/reboot
	install -Dm0755 poweroff.sh $(DESTDIR)$(PREFIX)/sbin/poweroff
	install -Dm0644 init.8      $(DESTDIR)$(MANPREFIX)/man8/init.8
	install -Dm0644 reboot.8    $(DESTDIR)$(MANPREFIX)/man8/reboot.8
	install -Dm0644 poweroff.8  $(DESTDIR)$(MANPREFIX)/man8/poweroff.8

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/sbin/init
	rm -f $(DESTDIR)$(PREFIX)/sbin/reboot
	rm -f $(DESTDIR)$(PREFIX)/sbin/poweroff
	rm -f $(DESTDIR)$(MANPREFIX)/man8/init.8
	rm -f $(DESTDIR)$(MANPREFIX)/man8/reboot.8
	rm -f $(DESTDIR)$(MANPREFIX)/man8/poweroff.8

clean:
	rm -f init init.8 poweroff.8 reboot.8

.PHONY:
	all install uninstall clean
