ARG STACK_VERSION
FROM heroku/heroku:$STACK_VERSION

ENV DEBIAN_FRONTEND noninteractive

# useful build tools ... we need gtk-doc to build orc, since they don't ship
# pre-baked tarballs
RUN apt-get update && apt-get install -y \
  build-essential \
  python3-pip \
  ninja-build \
  intltool \
  pkg-config

RUN pip3 install meson

# heroku buildpacks include some libraries, like tiff and jpeg, as part of the
# run-time platform, and we want to use those libs if we can
#
# see https://devcenter.heroku.com/articles/stack-packages
#
# libgsf needs libxml2
RUN apt-get update && apt-get install -y \
  glib-2.0-dev \
  libexpat-dev \
  librsvg2-dev \
  libpng-dev \
  libjpeg-dev \
  libtiff5-dev \
  libexif-dev \
  liblcms2-dev \
  libxml2-dev \
  libfftw3-dev \
  libpoppler-glib-dev \
  libwebp-dev \
  libmagickcore-dev

# build our stack to this prefix
ARG VIPS_PREFIX=/usr/local/vips

# ld and pkg-config need to pick up packages from this area
ENV LD_LIBRARY_PATH=$VIPS_PREFIX/lib
ENV PKG_CONFIG_PATH=$VIPS_PREFIX/lib/pkgconfig

# build area
WORKDIR /usr/local/src

# build liborc
ARG ORC_VERSION=0.4.32
ARG ORC_URL=https://gstreamer.freedesktop.org/src/orc

RUN wget ${ORC_URL}/orc-$ORC_VERSION.tar.xz \
  && tar xf orc-${ORC_VERSION}.tar.xz \
  && cd orc-${ORC_VERSION} \
  && meson build --prefix=${VIPS_PREFIX} --libdir=lib \
  && cd build \
  && ninja \
  && ninja install

# build libgsf
ARG GSF_VERSION=1.14.50
ARG GSF_URL=http://ftp.gnome.org/pub/GNOME/sources/libgsf

RUN wget ${GSF_URL}/${GSF_VERSION%.*}/libgsf-$GSF_VERSION.tar.xz \
  && tar xf libgsf-${GSF_VERSION}.tar.xz \
  && cd libgsf-${GSF_VERSION} \
  && ./configure --prefix=$VIPS_PREFIX --disable-gtk-doc \
  && make V=0 \
  && make install

# build libimagequant
ARG IMAGEQUANT_VERSION=main
ARG IMAGEQUANT_URL=https://github.com/lovell/libimagequant

RUN git clone $IMAGEQUANT_URL \
  && cd libimagequant \
  && git checkout $IMAGEQUANT_VERSION \
  && meson build --prefix=${VIPS_PREFIX} --libdir=lib \
  && cd build \
  && ninja \
  && ninja install

# build libcgif
ARG CGIF_VERSION=0.3.0
ARG CGIF_URL=https://github.com/dloebl/cgif/archive/refs/tags

RUN wget ${CGIF_URL}/V${CGIF_VERSION}.tar.gz \
  && tar xf V${CGIF_VERSION}.tar.gz \
  && cd cgif-${CGIF_VERSION} \
  && meson build --prefix=${VIPS_PREFIX} --libdir=lib \
  && cd build \
  && ninja \
  && ninja install

# build libspng
ARG SPNG_VERSION=0.7.2
ARG SPNG_URL=https://github.com/randy408/libspng/archive/refs/tags

RUN wget ${SPNG_URL}/v${SPNG_VERSION}.tar.gz \
  && tar xf v${SPNG_VERSION}.tar.gz \
  && cd libspng-${SPNG_VERSION} \
  && meson build --prefix=${VIPS_PREFIX} --libdir=lib \
  && cd build \
  && ninja \
  && ninja install

# build libde265
ARG DE265_VERSION=1.0.8
ARG DE265_URL=https://github.com/strukturag/libde265/releases/download

RUN wget ${DE265_URL}/v${DE265_VERSION}/libde265-${DE265_VERSION}.tar.gz \
  && tar xf libde265-${DE265_VERSION}.tar.gz \
  && cd libde265-${DE265_VERSION} \
  && ./autogen.sh \
  && ./configure --prefix=$VIPS_PREFIX \
  && make V=0 \
  && make install

# build libheif
ARG HEIF_VERSION=1.13.0
ARG HEIF_URL=https://github.com/strukturag/libheif/releases/download

RUN wget ${HEIF_URL}/v${HEIF_VERSION}/libheif-${HEIF_VERSION}.tar.gz \
  && tar xf libheif-${HEIF_VERSION}.tar.gz \
  && cd libheif-${HEIF_VERSION} \
  && ./configure --prefix=$VIPS_PREFIX \
  && make V=0 \
  && make install

# build libvips
ARG VIPS_VERSION=8.13.0
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
  && tar xzf vips-${VIPS_VERSION}.tar.gz \
  && cd vips-${VIPS_VERSION} \
  && ./configure --prefix=$VIPS_PREFIX \
  && make V=0 \
  && make install

# clean the build area ready for packaging
RUN cd $VIPS_PREFIX \
  && find bin/* -maxdepth 1 -not -name 'vips*' -delete \
  && rm bin/vips-* lib/*.a lib/*.la \
  && strip lib/lib*.so*

# export build artifacts
ARG STACK_VERSION
RUN cd $VIPS_PREFIX \
  && rm -rf build \
  && mkdir build \
  && tar czf "build/heroku-${STACK_VERSION}.tar.gz" bin include lib

# export config logs
ARG STACK_VERSION
RUN cd $VIPS_PREFIX \
  && echo "$ vips --vips-version" > "build/heroku-${STACK_VERSION}.config.log" \
  && ./bin/vips --vips-version >> "build/heroku-${STACK_VERSION}.config.log" \
  && echo "" >> "build/heroku-${STACK_VERSION}.config.log" \
  && echo "$ vips --vips-config" >> "build/heroku-${STACK_VERSION}.config.log" \
  && ./bin/vips --vips-config >> "build/heroku-${STACK_VERSION}.config.log"
