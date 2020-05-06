FROM amazonlinux:latest

RUN curl amazonlinux.default.amazonaws.com
RUN curl https://cdn.amazonlinux.com

RUN (yum update -y; \
    yum install -y openssh-server openssh-clients initscripts epel-release wget passwd tar screen crontabs unzip; \
    yum clean all)

RUN (/etc/init.d/sshd start; \
     sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config; \
     sed -i 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config; \
     sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config; \
     sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config)

RUN (mkdir -p /root/.ssh/; \
     echo "StrictHostKeyChecking=no" > /root/.ssh/config; \
     echo "UserKnownHostsFile=/dev/null" >> /root/.ssh/config)

RUN echo "root:amazonlinux" | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]