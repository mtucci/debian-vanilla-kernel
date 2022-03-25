FROM debian

COPY build-kernel.sh /build-kernel.sh
RUN apt update && apt install -y\
        curl build-essential bc kmod cpio flex bison rsync\
        libncurses5-dev libelf-dev libssl-dev openssl dwarves
ENTRYPOINT ["/build-kernel.sh"]
