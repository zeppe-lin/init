include config.mk

all:	init   respawn   halt   reboot   poweroff \
	init.8 respawn.1 halt.8 reboot.8 poweroff.8

%: %.in
	sed -e "s/#VERSION#/$(VERSION)/" $< > $@

init:
	$(CC) $(LDFLAGS) -o $@ init.c $(LDLIBS)

respawn:
	$(CC) $(LDFLAGS) -o $@ respawn.c estrtol.c eprintf.c $(LDLIBS)

halt:
	$(CC) $(LDFLAGS) -o $@ halt.c eprintf.c $(LDLIBS)

install: all
	install -Dm0644 halt.8     $(DESTDIR)$(MANDIR)/man8/halt.8
	install -Dm0644 respawn.1  $(DESTDIR)$(MANDIR)/man1/respawn.1
	install -Dm0644 init.8     $(DESTDIR)$(MANDIR)/man8/init.8
	install -Dm0644 poweroff.8 $(DESTDIR)$(MANDIR)/man8/poweroff.8
	install -Dm0644 reboot.8   $(DESTDIR)$(MANDIR)/man8/reboot.8
	install -Dm0755 halt       $(DESTDIR)$(BINDIR)/halt
	install -Dm0755 init       $(DESTDIR)$(BINDIR)/init
	install -Dm0755 poweroff   $(DESTDIR)$(BINDIR)/poweroff
	install -Dm0755 reboot     $(DESTDIR)$(BINDIR)/reboot
	install -Dm0755 respawn    $(DESTDIR)$(BINDIR)/respawn

uninstall:
	rm -f	$(DESTDIR)$(BINDIR)/halt
	rm -f	$(DESTDIR)$(BINDIR)/init
	rm -f	$(DESTDIR)$(BINDIR)/poweroff
	rm -f	$(DESTDIR)$(BINDIR)/reboot
	rm -f	$(DESTDIR)$(BINDIR)/respawn
	rm -f	$(DESTDIR)$(MANDIR)/man8/halt.8
	rm -f	$(DESTDIR)$(MANDIR)/man8/init.8
	rm -f	$(DESTDIR)$(MANDIR)/man8/poweroff.8
	rm -f	$(DESTDIR)$(MANDIR)/man8/reboot.8
	rm -f	$(DESTDIR)$(MANDIR)/man1/respawn.1

clean:
	rm -f	halt init poweroff reboot respawn \
		halt.8 init.8 poweroff.8 reboot.8 respawn.1 \
		*.o

.PHONY:
	all install uninstall clean
