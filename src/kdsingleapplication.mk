# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := kdsingleapplication
$(PKG)_WEBSITE  := https://github.com/KDAB/KDSingleApplication/
$(PKG)_DESCR    := helper class for single-instance policy applications
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.2.0
$(PKG)_CHECKSUM := ff4ae6a4620beed1cdb3e6a9b78a17d7d1dae7139c3d4746d4856b7547d42c38
$(PKG)_GH_CONF  := KDAB/KDSingleApplication/releases,v
$(PKG)_SUBDIR   := KDSingleApplication-$($(PKG)_VERSION)
$(PKG)_URL      := https://github.com/KDAB/KDSingleApplication/archive/$(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := qt6-qtbase

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
            -DCMAKE_INSTALL_LIBDIR='$(PREFIX)/$(TARGET)/lib' \
            -DKDSingleApplication_STATIC=True \
            -DCMAKE_BUILD_TYPE="Release" \
         '$(1)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' VERBOSE=1
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install VERBOSE=1
endef
