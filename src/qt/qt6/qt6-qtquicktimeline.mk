# This file is part of MXE. See LICENSE.md for licensing information.

include src/qt/qt6/qt6-conf.mk

PKG := qt6-qtquicktimeline
$(eval $(QT6_METADATA))

$(PKG)_CHECKSUM := b2ba57fa4fb929d3cd103dff65dd7a62dc2e3852f9a4fddd081e4a759b684fdd
$(PKG)_DEPS     := cc qt6-conf qt6-qtbase qt6-qtdeclarative

QT6_PREFIX   = '$(PREFIX)/$(TARGET)/$(MXE_QT6_ID)'
QT6_QT_CMAKE = '$(QT6_PREFIX)/$(if $(findstring mingw,$(TARGET)),bin,libexec)/qt-cmake-private' \
                   -DCMAKE_INSTALL_PREFIX='$(QT6_PREFIX)'

define $(PKG)_BUILD
    $(QT6_QT_CMAKE) -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' --build . -j '$(JOBS)'
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' --install .
endef
