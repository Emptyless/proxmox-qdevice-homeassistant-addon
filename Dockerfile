ARG BUILD_FROM
FROM ${BUILD_FROM}

# install corosync-qnetd and openssh-server
RUN apt update &&  \
    apt install -y corosync-qnetd openssh-server &&  \
    rm -rf /var/lib/apt/lists/*

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

# Expose corosync-qnetd port
EXPOSE 5403

# Expose SSH port
EXPOSE 22

CMD [ "/run.sh" ]