function install_grpc() {
  GRPC_RELEASE_TAG=v1.22.0

  command -v make >/dev/null 2>&1 || { echo >&2 "I require make but it's not installed.  Aborting."; exit 1; }
  command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it's not installed.  Aborting."; exit 1; }
  command -v ldconfig >/dev/null 2>&1 || { echo >&2 "I require ldconfig but it's not installed.  Aborting."; exit 1; }

  echo '-- fetching grpc -- '
  git clone -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc /var/local/git/grpc && \
    cd /var/local/git/grpc && \
    git submodule update --init --recursive

  echo '-- installing protobuf' && \
    cd /var/local/git/grpc/third_party/protobuf && \
    ./autogen.sh && ./configure --enable-shared && \
    make -j$(nproc) && make -j$(nproc) check && make install && make clean && ldconfig

  echo "-- installing grpc" && \
    cd /var/local/git/grpc && \
    make -j$(nproc) && make install && make clean && ldconfig
}
grpc=install_grpc