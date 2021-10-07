

vault=`grep server_name /home/ansible/AirBus/inventory/group_vars/prod/vars.yml`
vault=`echo $vault | awk -F': ' '{print $NF}'`
elasticpass=`ssh ansible@$vault cat /home/ansible/*pass | grep elastic`
elasticpass=`echo $elasticpass | awk -F' ' '{print $NF}'`
sleep 2

kibanapass=`ssh ansible@$vault cat /home/ansible/*pass | grep kibana | grep -v ystem`
kibanapass=`echo $kibanapass | awk -F' ' '{print $NF}'`
cd /home/ansible/AirBus/inventory/group_vars/prod/

sleep 2
awk '!/elastic_password/' vars.yml > tmpfile && mv tmpfile vars.yml

sleep 2
awk '!/kibana_password/' vars.yml > tmpfile && mv tmpfile vars.yml

elastring='elastic_password: "{{ vault_elastic_password }}"'
echo $elastring >> vars.yml

kibastring='kibana_password: "{{ vault_kibana_password }}"'
echo $kibastring >> vars.yml

sed -i "s/{{ vault_elastic_password }}/$elasticpass/g" vars.yml
sed -i "s/{{ vault_kibana_password }}/$kibanapass/g" vars.yml


