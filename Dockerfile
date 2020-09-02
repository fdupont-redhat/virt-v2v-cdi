FROM centos:8

RUN mkdir /disks && \
    yum -y update && \
    rm -rf /var/cache/yum && \
    yum install -y \
        qemu-guest-agent \
        qemu-img \
        qemu-kvm \
        virt-v2v \
        virtio-win && \
    yum install -y \
        --downloadonly \
        --downloaddir=/usr/share/virtio-win/linux/el8/ \
        qemu-guest-agent && \
    yum clean all

ENV LIBGUESTFS_BACKEND=direct

COPY bin/entrypoint /usr/bin/entrypoint

ENTRYPOINT ["/usr/bin/entrypoint"]
