include config.mk

all:	init   respawn   halt   reboot   poweroff   getty \
	init.8 respawn.1 halt.8 reboot.8 poweroff.8 getty.8

%: %.in
	sed -e "s/#VERSION#/$(VERSION)/" $< > $@

init:
	$(CC) $(LDFLAGS) -o $@ init.c $(LDLIBS)

getty:
	$(CC) $(LDFLAGS) -o $@ getty.c strlcpy.c eprintf.c $(LDLIBS)

respawn:
	$(CC) $(LDFLAGS) -o $@ respawn.c estrtol.c eprintf.c $(LDLIBS)

halt:
	$(CC) $(LDFLAGS) -o $@ halt.c eprintf.c $(LDLIBS)

install: all
	install -Dm0644 halt.8     $(DESTDIR)$(MANPREFIX)/man8/halt.8
	install -Dm0644 respawn.1  $(DESTDIR)$(MANPREFIX)/man1/respawn.1
	install -Dm0644 init.8     $(DESTDIR)$(MANPREFIX)/man8/init.8
	install -Dm0644 poweroff.8 $(DESTDIR)$(MANPREFIX)/man8/poweroff.8
	install -Dm0644 reboot.8   $(DESTDIR)$(MANPREFIX)/man8/reboot.8
	install -Dm0644 getty.8    $(DESTDIR)$(MANPREFIX)/man8/getty.8
	install -Dm0755 halt       $(DESTDIR)$(PREFIX)/sbin/halt
	install -Dm0755 init       $(DESTDIR)$(PREFIX)/sbin/init
	install -Dm0755 poweroff   $(DESTDIR)$(PREFIX)/sbin/poweroff
	install -Dm0755 reboot     $(DESTDIR)$(PREFIX)/sbin/reboot
	install -Dm0755 getty      $(DESTDIR)$(PREFIX)/sbin/getty
	install -Dm0755 respawn    $(DESTDIR)$(PREFIX)/bin/respawn

uninstall:
	rm -f	$(DESTDIR)$(PREFIX)/sbin/halt
	rm -f	$(DESTDIR)$(PREFIX)/sbin/init
	rm -f	$(DESTDIR)$(PREFIX)/sbin/poweroff
	rm -f	$(DESTDIR)$(PREFIX)/sbin/reboot
	rm -f	$(DESTDIR)$(PREFIX)/sbin/getty
	rm -f	$(DESTDIR)$(PREFIX)/bin/respawn
	rm -f	$(DESTDIR)$(MANPREFIX)/man8/halt.8
	rm -f	$(DESTDIR)$(MANPREFIX)/man8/init.8
	rm -f	$(DESTDIR)$(MANPREFIX)/man8/poweroff.8
	rm -f	$(DESTDIR)$(MANPREFIX)/man8/reboot.8
	rm -f	$(DESTDIR)$(MANPREFIX)/man8/getty.8
	rm -f	$(DESTDIR)$(MANPREFIX)/man1/respawn.1

clean:
	rm -f	halt   init   poweroff   reboot   respawn   getty   \
		halt.8 init.8 poweroff.8 reboot.8 respawn.1 getty.8 \
		*.o

.PHONY:
	all install uninstall clean
