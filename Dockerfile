FROM ubuntu:20.04

ENV TZ=America/Los_Angeles

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
 && apt-get update -y \
 && apt-get install -y curl wget git unzip iputils-ping net-tools vim cron make sudo npm \
 && apt-get install -y python3 python3-pip \
 && apt-get install -y perl libperl-dev libgd3 libgd-dev libgeoip1 libgeoip-dev geoip-bin libxml2 libxml2-dev libxslt1.1 libxslt1-dev \
 && apt-get install -y putty software-properties-common \
 && apt-add-repository ppa:ansible/ansible \
 && curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - \
 && sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
 && apt-get update -y \
 && apt-get install -y ansible terraform

RUN pip3 install pywinrm robotframework \
 && ansible-galaxy collection install ansible.windows

COPY ant/ansible /root/ansible
COPY ant/terraform /root/terraform
WORKDIR /root

ENV ANSIBLE_HOST_KEY_CHECKING=false
