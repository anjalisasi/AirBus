
useradd -m ansible
echo "ansible:ansible" | chpasswd

groupadd wheel 
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
usermod -a -G wheel ansible 

groupadd docker
usermod -a  -G docker ansible
