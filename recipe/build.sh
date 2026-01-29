#!/usr/bin/env bash
set -euo pipefail

mkdir -p build
cd build

# # necessary to ensure the gobject-introspection-1.0 pkg-config file gets found
# # meson needs this to determine where the g-ir-scanner script is located
export PKG_CONFIG="${BUILD_PREFIX}/bin/pkg-config"
export PKG_CONFIG_PATH="${BUILD_PREFIX}/lib/pkgconfig:${BUILD_PREFIX}/share/pkgconfig:${PREFIX}/lib/pkgconfig:${PREFIX}/share/pkgconfig:${PKG_CONFIG_PATH:-}"

echo "MESON_ARGS=${MESON_ARGS}"

meson ${MESON_ARGS:-} \
  --prefix="$PREFIX" \
  --backend=ninja \
  -Dintrospection=true \
  -Ddocs=false \
  -Dlibdir=lib \
  -Dvapi=true ..

ninja
ninja install
