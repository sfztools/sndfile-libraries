sudo apt-get install libjack-jackd2-dev lv2-dev pkg-config automake gettext libtool-bin cmake
apt-get source libogg-dev libvorbis-dev libflac-dev libsndfile

DESTDIR=${PWD}/${INSTALL_DIR}
PREFIX=/usr/local
FLAGS="-fPIC -DPIC -fvisibility=hidden -I${PREFIX}/include"

mkdir -p ${DESTDIR}

pushd libogg-1.3.2
CFLAGS=${FLAGS} CXXFLAGS=${FLAGS} PKG_CONFIG_LIBDIR=${PREFIX}/lib/pkgconfig ./configure --disable-shared --prefix=${PREFIX}
make -j$(nproc)
make install DESTDIR=${DESTDIR}
popd

pushd libvorbis-1.3.5
./autogen.sh
CFLAGS=${FLAGS} CXXFLAGS=${FLAGS} PKG_CONFIG_LIBDIR=${PREFIX}/lib/pkgconfig ./configure --disable-shared --prefix=${PREFIX}
make -j$(nproc)
make install DESTDIR=${DESTDIR}
popd

pushd flac-1.3.2
./autogen.sh
CFLAGS=${FLAGS} CXXFLAGS=${FLAGS} PKG_CONFIG_LIBDIR=${PREFIX}/lib/pkgconfig ./configure --disable-shared --prefix=${PREFIX}
make -j$(nproc)
make install DESTDIR=${DESTDIR}
popd

pushd libsndfile-1.0.28
CFLAGS=${FLAGS} CXXFLAGS=${FLAGS} PKG_CONFIG_LIBDIR=${PREFIX}/lib/pkgconfig ./configure --disable-shared --disable-full-suite --prefix=${PREFIX}
make -j$(nproc)
make install DESTDIR=${DESTDIR}
popd

mv *.txt ${INSTALL_DIR}
tar -zcvf "${INSTALL_DIR}.tar.gz" ${INSTALL_DIR}
