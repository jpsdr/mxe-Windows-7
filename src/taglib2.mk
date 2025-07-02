# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := taglib2
$(PKG)_WEBSITE  := https://taglib.org/
$(PKG)_DESCR    := TagLib v2
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.1.1
$(PKG)_CHECKSUM := 3716d31f7c83cbf17b67c8cf44dd82b2a2f17e6780472287a16823e70305ddba
$(PKG)_GH_CONF  := taglib/taglib/releases, v
$(PKG)_DEPS     := cc zlib

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
