# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := freetds
$(PKG)_WEBSITE  := https://www.freetds.org/
$(PKG)_DESCR    := FreeTDS
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.5.1
$(PKG)_CHECKSUM := 6146fde211b00583fad3c6d10030cfa664a744e0f5ae6b87edfd657bdf463b05
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://www.freetds.org/files/stable/$($(PKG)_FILE)
$(PKG)_URL_2    := https://fossies.org/linux/privat/$($(PKG)_FILE)
$(PKG)_DEPS     := cc openssl libiconv

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://www.freetds.org/files/stable/' | \
    $(SED) -n 's,.*freetds-\([0-9.]*\)\.tar.*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-rpath \
        --disable-dependency-tracking \
        --enable-libiconv \
        --enable-msdblib \
        --enable-sspi \
        --disable-threadsafe \
        --with-tdsver=7.2 \
        --with-openssl \
        PKG_CONFIG='$(TARGET)-pkg-config'
    $(MAKE) -C '$(1)' -j '$(JOBS)' install man_MANS=
endef
