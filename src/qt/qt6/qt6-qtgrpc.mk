# This file is part of MXE. See LICENSE.md for licensing information.

include src/qt/qt6/qt6-conf.mk

PKG := qt6-qtgrpc
$(eval $(QT6_METADATA))

$(PKG)_CHECKSUM := 052fa489d1c45b9df27319ee614f1534e49c9103a8b504024ab7e2c9e5b0849b
$(PKG)_DEPS     := cc qt6-conf qt6-qtbase

# Provides the Qt6::Protobuf and Qt6::Grpc runtime libraries. The code
# generators (qtprotobufgen, qtgrpcgen) are host tools: point QT_HOST_PATH
# at a native Qt of the same version when using qt_add_protobuf/qt_add_grpc.

QT6_PREFIX   = '$(PREFIX)/$(TARGET)/$(MXE_QT6_ID)'
QT6_QT_CMAKE = '$(QT6_PREFIX)/$(if $(findstring mingw,$(TARGET)),bin,libexec)/qt-cmake-private' \
                   -DCMAKE_INSTALL_PREFIX='$(QT6_PREFIX)'

define $(PKG)_BUILD
    $(QT6_QT_CMAKE) -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' --build . -j '$(JOBS)'
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' --install .
endef
