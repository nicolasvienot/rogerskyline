# Roger Skyline 1

## Getting Started

Install Virtual Box

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

## Configure Firewall

### Configure IPTABLES

##### Connect to VM with username
##### Add "bestiptables" in /etc/network/if-pre-up.d/

```bash
$> sudo chmod -x /etc/network/if-pre-up.d/bestiptables
$> sudo sh /etc/network/if-pre-up.d/bestiptables
$> sudo reboot
```

### Configure Fail2Ban

##### create log_paths if needed

```bash
$> sudo vim /etc/fail2ban/jail.local -> complete with own rules
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
