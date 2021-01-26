VERSION = 1.1

DESTDIR =
PREFIX  = /usr/local
BINDIR  = $(PREFIX)/sbin
MANDIR  = $(PREFIX)/share/man
ETCDIR  = /etc

CC      = cc
LD      = $(CC)
CFLAGS += -Wextra -Wall
#LDFLAGS += -s -static

# End of file
