vault=`grep server_name /home/ansible/Final/ELKStack/AirBus/inventory/group_vars/prod/vars.yml`
vault=`echo $vault | awk -F': ' '{print $NF}'`

cd /home/ansible/Final/ELKStack/AirBus/
scp DeleteAll.sh  ansible@$vault:/home/ansible
ssh ansible@$vault chmod 700 /home/ansible/DeleteAll.sh
ssh ansible@$vault /home/ansible/DeleteAll.sh
./Step3_Elkstack.sh
./Step4_Es_PerfTest.sh

