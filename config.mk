# inputattach version
VERSION = 1.24

# Customize below to fit your system

# paths
PREFIX = /usr/local

# libs
L=

# flags
CPPFLAGS = -DVERSION=\"${VERSION}\"
CFLAGS = -std=c99 -pedantic -Wall -O0 -g $(CPPFLAGS) $(foreach lib,$(L),$(shell pkg-config --cflags $(lib)))
LDFLAGS = $(foreach lib,$(L),$(shell pkg-config --libs $(lib)))
