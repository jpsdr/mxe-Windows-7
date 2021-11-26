# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := cmark
$(PKG)_WEBSITE  := https://github.com/commonmark/cmark
$(PKG)_DESCR    := CommonMark parsing and rendering library and program in C
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.30.3
$(PKG)_CHECKSUM := 85e9fb515531cc2c9ae176d693f9871774830cf1f323a6758fb187a5148d7b16
$(PKG)_GH_CONF  := commonmark/cmark/releases
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && \
        '$(TARGET)-cmake' '$(SOURCE_DIR)' \
        -DCMARK_STATIC=$(CMAKE_STATIC_BOOL) \
        -DCMARK_SHARED=$(CMAKE_SHARED_BOOL) \
        -DCMARK_TESTS=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' VERBOSE=1 || $(MAKE) -C '$(BUILD_DIR)' -j 1 VERBOSE=1
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install VERBOSE=1
endef
