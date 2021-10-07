#Airbus
#One time install of ansible / es clients on control box to comminicate to es docker and also build infra using pyuthon/ansible


apt update
apt install software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt install ansible
apt install python3-pip
apt install figlet 

#Install ES on control box for python clients etc to communicate to docker box/container .
pip install elasticsearch

