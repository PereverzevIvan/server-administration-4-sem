FROM ubuntu

ENV SSH_USERNAME=std

RUN apt update && \
    apt install -y openssh-server sudo git

RUN mkdir -p /run/sshd && \
    chmod 755 /run/sshd

RUN useradd -m -G sudo -s /bin/bash $SSH_USERNAME && \
    echo "$SSH_USERNAME:$SSH_USERNAME" | chpasswd

CMD ["/usr/sbin/sshd", "-D"]
