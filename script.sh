sudo apt-get install libjack-jackd2-dev lv2-dev pkg-config automake gettext libtool-bin cmake
apt-get source libogg-dev libvorbis-dev libflac-dev libsndfile

prefix=$(pwd)/prefix
flags="-fPIC -DPIC -fvisibility=hidden -I${prefix}/include"

mkdir -p $prefix
pushd libogg-1.3.2
CFLAGS=$flags CXXFLAGS=$flags PKG_CONFIG_LIBDIR=$prefix/lib/pkgconfig ./configure --disable-shared --prefix=$prefix
make -j$(nproc)
make install
popd

pushd libvorbis-1.3.5
./autogen.sh
CFLAGS=$flags CXXFLAGS=$flags PKG_CONFIG_LIBDIR=$prefix/lib/pkgconfig ./configure --disable-shared --prefix=$prefix
make -j$(nproc)
make install
popd

pushd flac-1.3.2
./autogen.sh
CFLAGS=$flags CXXFLAGS=$flags PKG_CONFIG_LIBDIR=$prefix/lib/pkgconfig ./configure --disable-shared --prefix=$prefix
make -j$(nproc)
make install
popd

pushd libsndfile-1.0.28
CFLAGS=$flags CXXFLAGS=$flags PKG_CONFIG_LIBDIR=$prefix/lib/pkgconfig ./configure --disable-shared --disable-full-suite --prefix=$prefix
make -j$(nproc)
make install
popd