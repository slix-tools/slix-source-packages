#!/usr/bin/env -S slix run slix-ld.slix -c bash --
# SPDX-FileCopyrightText: 2023 S. G. Gottlieb <info.simon@gottliebtfreitag.de>
# SPDX-License-Identifier: CC0-1.0
#
set -Eeuo pipefail

target=slix
git_url=https://github.com/SGSSGene/slix.git
version="0.0.4"
mkdir -p tmp-slix-source-build && cd $_
if [ -e ${target} ]; then
    rm -rf ${target}
fi
git clone ${git_url} ${target}
cd ${target};
BUILD_TYPE=release ./create-slix-ld.sh && mv slix-ld.gar ../..
#rm -rf ${target}
