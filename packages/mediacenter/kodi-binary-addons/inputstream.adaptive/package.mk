################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="inputstream.adaptive"
PKG_VERSION="db9b6a1"
PKG_SHA256="49035c28becc1029181b5e529c1afae3c3f5fd0fb4dd8c62c4caedc2735c3e08"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="https://github.com/liberty-developer/inputstream.adaptive/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="inputstream.adaptive"
PKG_LONGDESC="inputstream.adaptive"

PKG_IS_ADDON="yes"

post_makeinstall_target() {
  mkdir -p wv && cd wv
    cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DDECRYPTERPATH=special://home/cdm \
        $PKG_BUILD/wvdecrypter
    make

  cp -P $PKG_BUILD/.$TARGET_NAME/wv/libssd_wv.so $INSTALL/usr/lib
}

addon() {
  install_binary_addon $PKG_NAME $PKG_ADDON_ID

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib/
  cp -P $PKG_BUILD/.$TARGET_NAME/wv/libssd_wv.so $ADDON_BUILD/$PKG_ADDON_ID/lib
}
