#!/usr/bin/env -S slix run slix.slix -c bash --
# SPDX-FileCopyrightText: 2023 S. G. Gottlieb <info.simon@gottliebtfreitag.de>
# SPDX-License-Identifier: CC0-1.0

set -Eeuo pipefail

target=slix
git_url=https://github.com/SGSSGene/slix.git
version="0.1.7"
mkdir -p tmp-slix-source-build && cd $_
if [ -e ${target} ]; then
    rm -rf ${target}
fi
git clone ${git_url} ${target}
cd ${target};
BUILD_TYPE=release ./create-slix-ld.sh && mv slix-ld.gar ../..
BUILD_TYPE=release ./build.sh

hash=$(sha256sum -b ../../slix-ld.gar | awk '{print $1}')

mkdir -p ${target}-package/rootfs/usr/bin
mkdir -p ${target}-package/meta

cp build/bin/slix ${target}-package/rootfs/usr/bin/.slix-ld-slix
ln -s slix-ld ${target}-package/rootfs/usr/bin/slix
echo "slix" > ${target}-package/meta/name.txt
echo "${version}" > ${target}-package/meta/version.txt
echo "a user space package manager" > ${target}-package/meta/description.txt

(
    # r ! slix -Ssbd curl fuse3 fmt glibc slix-ld zstd xz yaml-cpp | sort -u | awk '{ print "    echo \"" $1 "\"" }'

    echo "acl@2.3.1-3#e57d41f1ef978a99e36a01b4e46d4d4c07edc8da9b81221e56257b40ba2d9950"
    echo "attr@2.5.1-3#f39707ca471d3a99a20b8879c2b3a98b2719d734fd0a0375b8a3f89c69439760"
    echo "bash@5.1.016-4#bb6879a3618e7def4ad9d04aa7418ee8aae8c1be5932ac746157ec37e475113d"
    echo "brotli@1.1.0-1#e0fc4dbc244d095c09434006e4b28a54e1d878630741bc4727635805383eea09"
    echo "ca-certificates@20220905-1#882fcb28108d5b8ef243411d3012cbaafee306511146098d791d595ec6e8e819"
    echo "ca-certificates-mozilla@3.94-1#0703a29b4952feee0a823a757fd3eabcdf82b555530de89c86e940681ae2b9c3"
    echo "ca-certificates-utils@20220905-1#49d65dcef5a6b68393eb2ce65a1c059672e0c252517ccfebd9c3afada0ac9ba6"
    echo "coreutils@9.4-2#4b66d0ebae06b7a99f3b634f50036837a3b9f23222faa06bfa48169e500cc3f6"
    echo "curl@8.4.0-2#8a5ce682de7275d3f1f5dcd67d40a4ba022fb1cb1b86e3ea15f1e8fd49895aa2"
    echo "e2fsprogs@1.47.0-1#bacf475fcd5c66a839e786fbe0986828a102bd344c20be92690667e90b7308d3"
    echo "findutils@4.9.0-3#2189c5bbd8cc8dad48ce4745ce62f5f9945aa737f925874a05dea27df300827a"
    echo "fmt@10.1.1-1#1b8285a8a02bfa8da5fd1a33a9259e495790642c66f540a5985e3de879976bab"
    echo "fuse3@3.16.2-1#4009c70007e00498a063aa7bb6d3415f3154a4f2d92968ec3881c12f68f8fed6"
    echo "gcc-libs@13.2.1-3#29cb8dc3caa82a68ca59582f1bf6551ae770bf6573dbf4b13564eac0ebcde242"
    echo "gdbm@1.23-2#fc420729fa8f424edab8bc1355396d803a482a23ca144df2a2ff6f20e51a5f91"
    echo "glibc@2.38-7#22c1c4e72d15161ea016586dfcc4e29188c814d978fbb1369638b42f716260e1"
    echo "gmp@6.3.0-1#10007356cbc6acf7aa580ecbdfc20aa2c042b10b9ae0702342f577ad879cdb59"
    echo "keyutils@1.6.3-2#6c7ad346015fc12ce177ea9d5ce64b25c26fecd53c5ce2cc1fe6ee044725c0f9"
    echo "krb5@1.20.1-1#6ba1aaa31d206a839f05b5b03a6bff9490752f77ae57a2a22a49a9ccc58aa0c4"
    echo "libcap@2.69-1#288031bc43e37f2d90ed8099aad9b70d8af5a543df913bdbad43affac2cd8b07"
    echo "libevent@2.1.12-4#3f3e585b9aaf35a266edf33c7245863d926ff942c400a73193f984bea52bcc71"
    echo "libffi@3.4.4-1#7068ca1cc5f87093aed30f93a09173b031fec27058366e8a8db550ade5cac79f"
    echo "libgcrypt@1.10.2-1#5f9a0734672686103b4b540e3173df295eb63e7ad02412bdde24e0c7ea91a2ee"
    echo "libgpg-error@1.47-1#0eb69b9c8485002f6031b7b8f6b00ca5ea2cd7508071d13d36b5c9b3f1c4a4f8"
    echo "libidn2@2.3.4-3#628a2ad0869718ecaeeea400336497eb6b8aba36e2c813706003349d0c8072d1"
    echo "libldap@2.6.6-2#c343afa2202370959a1bddce0ff49e7a7377905b7385a48ce4db2896d5f3eccc"
    echo "libnghttp2@1.57.0-1#af76ab3fa75296107d6d13d94225fd105495ba7697de57483a703b15f35890e3"
    echo "libp11-kit@0.25.0-2#cc31b697f283a0af47b3364f3f61446a18bae2a85e0ae56401d35dab6b4f9fd9"
    echo "libpsl@0.21.2-1#f5706aa88265439582974b24f89e82c58b4c568b1fa77f36246baeda7d30f2a2"
    echo "libsasl@2.1.28-4#59833cdc2d5087433c8be0a280a35377c00f0a04941d2f3a63a9a71ee1606381"
    echo "libssh2@1.11.0-1#d00846ff7b5d987546dc6e9d0980ac53fcfe78aebc7237517186d87405feaa88"
    echo "libtasn1@4.19.0-1#a71b96f241ebd0be8a782070d80f646e5b814b1c5e680aca4d0c2bfbb2333685"
    echo "libunistring@1.1-2#d5ebd9561cece8f7d99effe23bb415ebd4d0636183f8bca390d24d5aabcc9ae6"
    echo "libverto@0.3.2-4#7caec58eaa16b90e0560fafb185d4ded428074699c83e4d6f329ffc22d689f4a"
    echo "lz4@1:1.9.4-1#fb863aa85df68a2f947f0380403cbbe0ac896a6d6729d6ed1458e256247b2b6d"
    echo "ncurses@6.4_20230520-1#cb910abd974a2980fe2dd8d0dce7f5c3f06e67278ce52486076c86384b11bb3b"
    echo "openssl@3.1.4-1#348afd6b15ea4480af325b4aaabe93a5d68183db3fbdb05a54d0aefd250ad357"
    echo "p11-kit@0.25.0-2#af25fa62221e71036417deaaeb15110ab2e01e68054f476f5664cb1fd2cc090e"
    echo "pam@1.5.3-3#422e93ae1496a8c8c92a98415c877f2be2b24f3ed527b980a2b4fb2558c17eaa"
    echo "readline@8.2.001-2#95f35ec5bb412ed0492e4b9573bc4f910e767660805109d88d513e4bc439300b"
    echo "slix-ld@0.0.4#1a237cf30252124fcfdd647e8c824bf192b212f0b9fe9c212d42f0744bcbd063"
    echo "systemd-libs@254.5-1#85b92d3c821038cf053623577be0c1918f91fd44768e0008445c41ecb89c2978"
    echo "util-linux-libs@2.39.2-1#7c011d455c59eca2268449d731e257b7a1df473b7221f81f2b9a944ac8c92f7e"
    echo "xz@5.4.4-1#c292de896bc542ca79b56fdd045323bbc17796acdc5d6a21e751165580a93e8d"
    echo "yaml-cpp@0.8.0-1#30b5d0541c285819d65870cec5e0afcc9faa27944094fb2c89d59483b13c428a"
    echo "zlib@1:1.3-1#2cc11e1cbfda183927815b09239732861509350db711c07a8250cea1a1c84a16"
    echo "zstd@1.5.5-1#603f786f6a7c649117157e80276d7d4bab4b2ffd55884e4855457a4be2eea118"
) > ${target}-package/meta/dependencies.txt

#export PATH=${PATH}:${HOME}/.local/bin
slix archive --input ${target}-package --output ../../${target}.gar

cd ..
#rm -rf ${target}
#
cd ..
cp ${target}.gar ${target}@${version}#$(sha256sum ${target}.gar | awk '{print $1}')
