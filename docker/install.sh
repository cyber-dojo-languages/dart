#!/bin/sh -eu

# Puts dart on a PATH every shell has, and records the Dart the base image
# turned out to carry.

# The base image adds /usr/lib/dart/bin to PATH with ENV, which a shell that
# resets PATH does not see. dart finds its SDK from its own resolved path, so
# a symlink works as well as the real binary.
ln --symbolic /usr/lib/dart/bin/dart /usr/local/bin/dart

# Asked of the SDK, so /versions.json states the version this image holds
# rather than one written down when someone last edited it.
# dart --version prints "Dart SDK version: 3.13.5 (stable) (...)".
readonly DART_VERSION=$(dart --version | cut -d' ' -f4)
cat > /versions.json <<EOF
{
  "language": {
    "name": "Dart",
    "version": "${DART_VERSION}"
  },
  "test_frameworks": []
}
EOF
