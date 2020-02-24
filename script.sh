#!/bin/bash

set -e

DESTDIR="${PWD}/${INSTALL_DIR}"
PREFIX="/usr/local"
FLAGS="-fPIC -DPIC -fvisibility=hidden -I${PREFIX}/include"
OGGVER=1.3.4
VORBISVER=1.3.6
FLACVER=1.3.3
SNDFILEVER=1.0.28

mkdir -p "${DESTDIR}"

wget -qO ogg-${OGGVER}.tar.gz         https://github.com/xiph/ogg/archive/v${OGGVER}.tar.gz
wget -qO vorbis-${VORBISVER}.tar.gz   https://github.com/xiph/vorbis/archive/v${VORBISVER}.tar.gz
wget -qO flac-${FLACVER}.tar.gz       https://github.com/xiph/flac/archive/${FLACVER}.tar.gz
wget -qO sndfile-${SNDFILEVER}.tar.gz https://github.com/erikd/libsndfile/archive/${SNDFILEVER}.tar.gz

tar xzf ogg-${OGGVER}.tar.gz
tar xzf vorbis-${VORBISVER}.tar.gz
tar xzf flac-${FLACVER}.tar.gz
tar xzf sndfile-${SNDFILEVER}.tar.gz

pushd ogg-${OGGVER}
./autogen.sh
CFLAGS=${FLAGS} CXXFLAGS=${FLAGS} PKG_CONFIG_LIBDIR=${PREFIX}/lib/pkgconfig ./configure --disable-shared --prefix=${PREFIX}
make -j$(nproc)
make install DESTDIR=${DESTDIR}
sudo make install
popd

pushd vorbis-${VORBISVER}
./autogen.sh
CFLAGS=${FLAGS} CXXFLAGS=${FLAGS} PKG_CONFIG_LIBDIR=${PREFIX}/lib/pkgconfig ./configure --disable-shared --prefix=${PREFIX}
make -j$(nproc)
make install DESTDIR=${DESTDIR}
sudo make install
popd

pushd flac-${FLACVER}
./autogen.sh
CFLAGS=${FLAGS} CXXFLAGS=${FLAGS} PKG_CONFIG_LIBDIR=${PREFIX}/lib/pkgconfig ./configure --disable-shared --prefix=${PREFIX}
make -j$(nproc)
make install DESTDIR=${DESTDIR}
sudo make install
popd

pushd libsndfile-${SNDFILEVER}
./autogen.sh
CFLAGS=${FLAGS} CXXFLAGS=${FLAGS} PKG_CONFIG_LIBDIR=${PREFIX}/lib/pkgconfig ./configure --disable-shared --disable-full-suite --prefix=${PREFIX}
make -j$(nproc)
make install DESTDIR=${DESTDIR}
popd

#rm -rf ${INSTALL_DIR}/${PREFIX}/bin ${INSTALL_DIR}/${PREFIX}/share/doc ${INSTALL_DIR}/${PREFIX}/share/man

mv *.txt ${INSTALL_DIR}
tar -zcvf "${INSTALL_DIR}.tar.gz" ${INSTALL_DIR}
