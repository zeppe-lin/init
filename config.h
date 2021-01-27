/* See LICENSE file for copyright and license details. */

static char *const rcinitcmd[]     = { "/etc/rc.boot",                 NULL };
static char *const rcrebootcmd[]   = { "/etc/rc.shutdown", "reboot",   NULL };
static char *const rcpoweroffcmd[] = { "/etc/rc.shutdown", "poweroff", NULL };

#undef UTMP_PATH
#define UTMP_PATH       "/var/run/utmp"

