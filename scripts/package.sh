#!/bin/bash

set -e

if [ -n "$DIST_VERSION" ]; then
    version=$DIST_VERSION
else
    version=`git describe --dirty --tags || echo unknown`
fi

npm run build

mkdir -p dist
cp -r build matrix-dimension-$version

# if $version looks like semver with leading v, strip it before writing to file
if [[ ${version} =~ ^v[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+(-.+)?$ ]]; then
    echo ${version:1} > matrix-dimension-$version/version
else
    echo ${version} > matrix-dimension-$version/version
fi

tar chvzf dist/matrix-dimension-$version.tar.gz matrix-dimension-$version
rm -r matrix-dimension-$version

echo
echo "Packaged dist/matrix-dimension-$version.tar.gz"
