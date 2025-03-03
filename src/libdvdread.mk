# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libdvdread
$(PKG)_WEBSITE  := https://www.videolan.org/developers/libdvdnav.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.1.3
$(PKG)_CHECKSUM := ce35454997a208cbe50e91232f0e73fb1ac3471965813a13b8730a8f18a15369
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://download.videolan.org/pub/videolan/$(PKG)/$($(PKG)_VERSION)/$($(PKG)_FILE)

# libdvdread supports libdvdcss either by dynamic loading (dlfcn-win32) or
# directly linking to libdvdcss. We directly link to the library here.
$(PKG)_DEPS     := cc libdvdcss

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://download.videolan.org/pub/videolan/libdvdread/' | \
    $(SED) -n 's,.*href="\([0-9][^<]*\)/".*,\1,p' | \
    grep -v 'alpha\|beta\|rc' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    # build and install the library
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-dlfcn \
        --with-libdvdcss \
        --disable-apidoc
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' LDFLAGS=-no-undefined
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install LDFLAGS=-no-undefined
endef
