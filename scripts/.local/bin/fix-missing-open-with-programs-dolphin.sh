#!/bin/bash

pkgname=plasma-workspace
pkgver=6.0.4
_dirver=$(echo $pkgver | cut -d. -f1-3)

mkdir temp && cd temp
wget "https://download.kde.org/stable/plasma/$_dirver/$pkgname-$pkgver.tar.xz"
# note the filename that was downloaded
tar -xJf plasma-workspace-6.0.4.tar.xz
find . -name "*.menu"
mkdir ~/.config/menus
cp plasma-workspace-6.0.4/menu/desktop/plasma-applications.menu ~/.config/menus/applications.menu
kbuildsycoca6
cd .. && rm -rf temp
