FROM alpine:3.11

# expose port
EXPOSE 3306

# install console tools
RUN apk add \
    curl \
    inotify-tools \
    nano \
    tar \
    unzip

# install zsh
RUN apk add \
    zsh \
    zsh-vcs

# configure zsh
ADD --chown=root:root include/zshrc /etc/zsh/zshrc

# install openrc
RUN apk add \
    openrc

# install mariadb
RUN apk add \
    mariadb \
    mariadb-client

# enable remote connections to mariadb from any IP
RUN sed -i 's|skip-networking|#skip-networking|g' /etc/my.cnf.d/mariadb-server.cnf
RUN sed -i 's|#bind-address=0.0.0.0|bind-address=0.0.0.0|g' /etc/my.cnf.d/mariadb-server.cnf

# hack to add mariadb as a service
RUN rc-status; \
    rc-update add mariadb; \
    touch /run/openrc/softlevel

# necessary for services to be started
VOLUME ["/sys/fs/cgroup"]

# make database persistent
VOLUME ["/var/lib/mysql"]

# add scripts
ADD --chown=root:root include/start.sh /start.sh
ADD --chown=mysql:mysql include/init.sql /init.sql

# make entry point script executable
RUN chmod +x /start.sh

# set working dir
WORKDIR /var/lib/mysql/

ENTRYPOINT ["/start.sh"]