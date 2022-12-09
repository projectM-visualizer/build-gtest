#!/bin/sh

ARCHIVE_ZIP="release-1.12.1.zip"
ARCHIVE_SRC="https://github.com/google/googletest/archive/refs/tags/$ARCHIVE_ZIP"
ARCHIVE_DIR="googletest-release-1.12.1"

# ---

rm -rf dist
mkdir -p dist
rm -rf build
mkdir -p build
cd build

if [ ! -f $ARCHIVE_ZIP ]; then
  echo "DOWNLOADING $ARCHIVE_SRC"
  echo
  curl -L -O $ARCHIVE_SRC

  if [ $? != 0 ] || [ ! -f $ARCHIVE_ZIP ]; then
    echo "DOWNLOADING FAILED!"
    exit 1
  fi
fi

# ---

echo
echo "UNPACKING $ARCHIVE_ZIP..."
unzip -q $ARCHIVE_ZIP

if [ $? != 0 ] || [ ! -d $ARCHIVE_DIR ]; then
  echo "UNPACKING FAILED!"
  exit 1
fi

mv $ARCHIVE_DIR src

# ---

cd ..

export GTEST_PATH="$(pwd)"
alias RUN_TEST='ctest -S $GTEST_PATH/cmake/run.cmake -VV'
