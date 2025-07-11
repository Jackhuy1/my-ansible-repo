export DEBIAN_FRONTEND=noninteractive
echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections
sudo apt-get update
sudo apt-get install apt-utils -y

sudo apt update && sudo apt upgrade -y

sudo apt install -y wget gpg git

export UBUNTU_CODENAME=jammy
wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list

sudo apt update && sudo apt install -y ansible

export ANSIBLE_HOST_KEY_CHECKING=false
cd /home/$USER
git clone https://github.com/Jackhuy1/my-ansible-repo.git

cd /home/$USER/my-ansible-repo

ansible-playbook -i inventory.ini playbook.yaml
ansible-playbook -i inventory.ini playbook-mysql.yaml
ansible-playbook -i inventory.ini playbook-restore-db.yaml
