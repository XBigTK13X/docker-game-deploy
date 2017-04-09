#! /bin/bash

set -e

CONYAY="/root/conyay"
WORKSPACE="/root/source"

if [ ! -z $CI_PROJECT_DIR ]; then
    WORKSPACE=${CI_PROJECT_DIR}
fi

if [ -z $TITLE_PRETTY ]; then
    echo "TITLE_PRETTY env required"
    exit 1
fi

if [ -z $TITLE_ID ]; then
    echo "TITLE_ID env required"
    exit 1
fi

if [ -z $BUTLER_API_KEY ]; then
    echo "BUTLER_API_KEY env required"
    exit 1
fi

if [ ! "$(ls -A ${WORKSPACE})" ]; then
    echo "mount at /root/source required"
    exit 1
fi

cd ${WORKSPACE}
script/prepare_package.sh

cd ${CONYAY}
/bin/bash -c "./power.sh ${TITLE_PRETTY} ${WORKSPACE}/pkg"

push(){
    ZIP=$1
    CHANNEL=$2

    /root/butler push ${CONYAY}/rap/${TITLE_PRETTY}/packages/${ZIP} simplepathstudios/${TITLE_ID}:${CHANNEL} --userversion-file ${WORKSPACE}/assets/data/version.dat
}

push ${TITLE_PRETTY}-lin-64.zip linux
push ${TITLE_PRETTY}-lin-32.zip linux-thirytwobit
push ${TITLE_PRETTY}-mac.zip osx
push ${TITLE_PRETTY}-win-32.zip windows
