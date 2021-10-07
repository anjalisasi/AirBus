
figlet -c "AIRBUS - ELK stack crating ..."

ansible-playbook -i inventory elk.yml --tags elasticsearch

sleep 20

./passwordscrapper.sh

sleep 20 

ansible-playbook -i inventory elk.yml --tags kibana

ansible-playbook -i inventory elk.yml --tags logstash

#ansible-playbook -i inventory elk.yml --tags nginx

