#!/bin/bash
#set variables
PATH=/usr/local/bin:/usr/bin:/bin
fingerprint=0EBFCD88

#Remove already installed components if its exist
function rm_docker(){
	apt remove -y docker-ce docker-ce-cli runc containerd.io runc
}

#Install components for docker
function install_common(){
	apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common 
}
#Install docker service
function install_docker(){
	apt install -y docker-ce docker-ce-cli containerd.io
}
#Add gpg_key
function add_gpg(){
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
}
#Add repo for docker
function add_repo(){
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
}
#check if docker binary exists
if [[ -e /usr/bin/docker ]]; then
	echo "Docker already installed...Remove current" &&
	rm_docker
else
    echo "Docker will be installed" &&
	install_common &&
	add_gpg &&
	apt-key fingerprint ${fingerprint} &&
	add_repo &&
	apt update &&
	install_docker &&
	docker -v
fi
