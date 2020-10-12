FROM opensuse/leap:15.2
# To speed up development of this role. It does exactly the same as found in molecule/default/converge.yml
ENV container docker
RUN zypper install -y python3 sudo module-init-tools dbus-1 systemd-container cron python3-rpm\
    grub2 openssh
RUN cp /usr/lib/systemd/system/dbus.service /etc/systemd/system/ 
RUN systemctl mask console-getty.service; \
    systemctl mask systemd-logind.service; \
    systemctl mask system; \
    systemctl mask systemd-modules-load.service
VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd", "--system"]

