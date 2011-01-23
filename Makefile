# uuwm - micro window manager
# See LICENSE file for copyright and license details.

include config.mk

INPUTATTACH = inputattach
INPUTATTACHV = ${INPUTATTACH}-${VERSION}
SRC = ${INPUTATTACH}.c
OBJ = ${SRC:.c=.o}

all: options ${INPUTATTACH}

options:
	@echo ${INPUTATTACH} build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.mk

${INPUTATTACH}: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f ${INPUTATTACH} ${OBJ} ${INPUTATTACHV}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p ${INPUTATTACHV}
	@cp -R Makefile config.mk ${SRC} ${INPUTATTACHV}
	@tar -czf ${INPUTATTACHV}.tar ${INPUTATTACHV}
	@rm -rf ${INPUTATTACHV}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/sbin
	@mkdir -p ${DESTDIR}${PREFIX}/sbin
	@cp -f ${INPUTATTACH} ${DESTDIR}${PREFIX}/sbin
	@chmod 755 ${DESTDIR}${PREFIX}/sbin/${INPUTATTACH}

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/sbin
	@rm -f ${DESTDIR}${PREFIX}/sbin/${INPUTATTACH}

.PHONY: all options clean dist install uninstall
