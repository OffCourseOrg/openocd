#!/bin/sh

set -xe

# build_dir=$PWD
# #
# for build_file in $(find . -name "build.sh" ! -path "./build.sh"); do
#   echo executing $build_file
#   cd $(dirname $build_file)
#   ./build.sh
#   cd $build_dir
# done
# #
# #
./bootstrap
#
export EM_PKG_CONFIG_PATH="./libusb/:./jimtcl"

emconfigure ./configure \
  --enable-ftdi=yes \
  --enable-stlink=no \
  --enable-ti-icdi=no \
  --enable-ulink=no \
  --enable-angie=no \
  --enable-usb-blaster-2=no \
  --enable-ft232r=no \
  --enable-vsllink=no \
  --enable-xds110=no \
  --enable-osbdm=no \
  --enable-opendous=no \
  --enable-armjtagew=no \
  --enable-rlink=no \
  --enable-usbprog=no \
  --enable-esp-usb-jtag=no \
  --enable-cmsis-dap-v2=no \
  --enable-cmsis-dap=no \
  --enable-nulink=no \
  --enable-kitprog=no \
  --enable-usb-blaster=no \
  --enable-presto=no \
  --enable-openjtag=no \
  --enable-linuxgpiod=no \
  --enable-remote-bitbang=no \
  --enable-linuxspidev=no \
  --enable-buspirate=no \
  --enable-dummy=no \
  --enable-vdebug=no \
  --enable-jtag-dpi=no \
  --enable-jtag-vpi=no \
  --enable-rshim=no \
  --enable-xlnx-pcie-xvc=no \
  --enable-jlink=no \
  --with-capstone=no \
  --disable-assert \
  --disable-werror \
  --host=wasm32-unknown-emscripten \
  --enable-emscripten-object \
   CPPFLAGS="-I./jimtcl/ -I./libusb/libusb/" LDFLAGS="-L./libusb/libusb/.libs/ -L./jimtcl/ -lembind --bind -sASYNCIFY -sALLOW_MEMORY_GROWTH" \
#
emmake make -j$(nproc)

cp ./src/.libs/libopenocd.a libopenocd.a

#final build wihtout js files
# emcc -o openocd.html main.c src/.libs/libopenocd.a -I./jimtcl/ -I./libusb/libusb/ -L./libusb/libusb/.libs/ -L./jimtcl/ -lembind --bind -sASYNCIFY -sALLOW_MEMORY_GROWTH -lusb-1.0 -ljim
