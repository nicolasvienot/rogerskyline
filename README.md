# Roger Skyline 1

## Getting Started

Install Virtual Box

### Debian Version

debian-9.8.0-amd64-netinst

### Install Debian

##### Region
Language : english
Zone : France
Keyboard : American english
##### Admin
Hostname : roger
Domain : 42.fr
Password root : xxxxxx
##### Non-admin account
Full name : xxxx
Username : xxxx
Password : xxxx
##### Partition disks
Type : Manual
1st partition : 4.5gb, primary, beggining, ext4, mounted on /
2nd partition : 1gb, primary, beggining, swap
3rd partition : rest, primary, ext4, mounted on /home
##### Package manager
Country : France
Mirror : ftp.fr.debian.org
##### Config
HTTP proxy : no
Software selection : Select [SSH server] [Standard system utilities]
Instal the GRUB boot loader : yes

### Configure SSH

##### Connect to VM with previous login/password
```bash
$> su
$> apt-get update && apt-get upgrade
$> apt-get install sudo vim iptables-persistent fail2ban sendmail apache2 portsentry
$> adduser (your non-admin user) sudo
$> replace > with own | etc/network/interface -> choose your IP
$> replace > with own | etc/ssh/sshd_config (modify password autentification to 'yes') -> choose your port
$> reboot
```
##### On host
```bash
$> ssh-keygen
$> cat ~/.ssh/id_rsa.pub
```
##### Copy keygen
```bash
$> ssh [VMUSERNAME]@[VMIP] -p [VMSSHPORT]
$> sudo mkdir .ssh
$> sudo vim .ssh/authorized_keys -> paste pub key 
$> sudo vim /etc/ssh/sshd_config (replace password autentification 'yes' to 'no')
$> sudo service ssh restart
$> sudo reboot
```
You can now access your VM with ssh [VMUSERNAME]@[VMIP] -p [VMSSHPORT] without using password and with pubkeys. Root can't access.

### Configure Firewall
### Scripts
### Web server && SSL
### Deployment
