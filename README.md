# Roger Skyline 1

## Getting Started

### Install and configure Virtual Box

Install Virtual Box <br>
Link Virtual Box to your sgoinfre <br>
Create a folder [your_login]/VM in the sgoinfre and give right access to it <br>
Go to Virtual Box -> Preferences -> General -> Default Machine Folder and put : <br>
/sgoinfre/goinfre/Perso/[your login]/VM <br>

### Create VM

Create a new VM, using Debian and with Bridge network, then launch your new VM and select your debian iso.

### Debian Version

debian-9.8.0-amd64-netinst

## Install Debian

##### Region
Language : english <br>
Zone : France <br>
Keyboard : American english <br>
##### Admin
Hostname : roger <br>
Domain : 42.fr <br>
Password root : xxxxxx <br>
##### Non-admin account
Full name : xxxx <br>
Username : xxxx <br>
Password : xxxx <br>
##### Partition disks
Type : Manual
1st partition : 4.5gb, primary, beggining, ext4, mounted on / <br>
2nd partition : 1gb, primary, beggining, swap <br>
3rd partition : rest, primary, ext4, mounted on /home <br>
##### Package manager
Country : France <br>
Mirror : ftp.fr.debian.org <br>
##### Config
HTTP proxy : no <br>
Software selection : Select [SSH server] [Standard system utilities] <br>
Instal the GRUB boot loader : yes <br>

## Configure SSH

##### Connect to VM with previous login/password
```bash
$> su
$> apt-get update -y && apt-get upgrade -y
$> apt-get install sudo vim iptables-persistent fail2ban sendmail apache2 portsentry
$> adduser [your_non-admin_user] sudo
$> replace etc/network/interface with file in [Files_config] + choose your IP
$> replace etc/ssh/sshd_config with file in [Files_config] + modify password authentification to 'yes' + choose your port
$> reboot
```
##### On host
```bash
$> ssh-keygen
$> cat ~/.ssh/id_rsa.pub
```
##### Copy pubkey and paste it in :
```bash
$> ssh [VM_USERNAME]@[VM_IP] -p [VM_SSH_PORT]
$> sudo mkdir .ssh
$> sudo vim .ssh/authorized_keys -> paste pub key 
$> sudo vim /etc/ssh/sshd_config (replace password autentification 'yes' to 'no')
$> sudo service ssh restart
$> sudo reboot
```
Or simply use : ssh-copy-id -i id_rsa.pub [VM_USERNAME]@[VM_IP] -p [VM_SSH_PORT] to copy/paste your pubkey

You can now access your VM with ssh [VMUSERNAME]@[VMIP] -p [VMSSHPORT] without using password and with pubkeys. Root can't access.

## Configure Firewall

### Configure IPTABLES

##### Connect to VM with username
##### Add "bestiptables" in /etc/network/if-pre-up.d/ -> careful, don't put any extension!


```bash
$> sudo chmod 777 /etc/network/if-pre-up.d/bestiptables
$> sudo sh /etc/network/if-pre-up.d/bestiptables
$> sudo reboot
```

### Configure Fail2Ban

##### create log_paths if needed

```bash
$> sudo vim /etc/fail2ban/jail.local -> complete with your own rules
$> sudo systemctl restart fail2ban.service
$> sudo reboot
```

##### To try

```bash
$> sudo cat /var/log/fail2ban
$> sudo iptables -L
$> sudo iptables -S
```

### Configure Portsentry

https://fr-wiki.ikoula.com/fr/Se_prot%C3%A9ger_contre_le_scan_de_ports_avec_portsentry

### Try DOS attack with SlowLoris

##### Download SlowLoris from current repository

Try using commands on host :
```bash
$> perl slowloris.pl -dns [STATIC IP VM] -port [SSH PORT VM]
$> perl slowloris.pl -dns [STATIC IP VM] -port 80
$> perl slowloris.pl -dns [STATIC IP VM] -port 443
$> perl slowloris.pl -dns [STATIC IP VM] -port 25
```

##### Slowloris should not be able to send any packets and IP should be banned from VM (see logs portsentry and iptbles)

### Try ports scan with nmap

##### Clone your VM and change IP and PORT

```bash
$> sudo aptget install nmap
```

##### Try using it

```bash
$> nmap -Pn [IP_VM_TO_TEST]
$> nmap [IP_VM_TO_TEST]
```
##### Nmap should not be able to scan your ports and IP trying to scan should be banned (see logs portsentry and iptbles)

## Scripts

##### Implement scripts on a folder and modify /etc/crontab

See Files_config

##### Configure sendmail
```bash
$> sudo sendmailconfig
$> sudo reboot
```

##### To try
Create a file mail.txt with content
```bash
$> sudo sendmail xxxx@xxx.com < /home/xxx/email.txt
```

## Web server && SSL

##### Generate a new SSL key
```bash
$> sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/rogerxxx.com.key -out /etc/ssl/certs/rogerxxx.com.crt
$> sudo vim /etc/apache2/sites-available/default-ssl.conf
```
##### Check on Files_config
```bash
$> sudo apachectl configtest
$> sudo a2enmod ssl
$> sudo a2ensite default-ssl
$> sudo systemctl restart apache2.service
$> sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/001-default.conf
$> sudo vim /etc/apache2/sites-available/001-default.conf
```
##### Check on Files_config
```bash
$> a2dissite 000-default.conf
$> a2ensite 001-default.conf
$> systemctl reload apache2
```
##### Modify content of website in /var/www

## Deployment

nvienot
