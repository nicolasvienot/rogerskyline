# Roger Skyline 1

## Getting Started

Install Virtual Box

### Debian Version

debian-9.8.0-amd64-netinst

### Install Debian

-- Region
Language : english
Zone : France
Keyboard : American english
-- Admin
Hostname : roger
Domain : 42.fr
Password root : xxxxxx
-- Non-admin account
Full name : xxxx
Username : xxxx
Password : xxxx
-- Partition disks
Type : Manual
1st partition : 4.5gb, primary, beggining, ext4, mounted on /
2nd partition : 1gb, primary, beggining, swap
3rd partition : rest, primary, ext4, mounted on /home
-- Package manager
Country : France
Mirror : ftp.fr.debian.org
-- Config
HTTP proxy : no
Software selection : Select [SSH server] [Standard system utilities]
Instal the GRUB boot loader : yes

### Configure SSH

1. Connect to VM with previous login/password
```bash
$> su
$> su
$> su
```
-- su
-- apt-get update && apt-get upgrade
-- apt-get install sudo vim iptables-persistent fail2ban sendmail apache2 portsentry
-- adduser X
-- adduser X sudo
-- replace > with own | etc/network/interface
-- replace > with own | etc/ssh/sshd_config (modify password autentification to 'yes')
-- reboot
3. On host (iTerm2)
-- ssh-keygen
-- cat ~/.ssh/id_rsa.pub
-- Save key
-- ssh [USERNAME.VM]@[IP.VM] -p [PORT.SSH.VM]
-- sudo mkdir .ssh
-- sudo vim .ssh/authorized_keys -> paste pub key 
-- replace password autentification 'yes' to 'no' on etc/ssh/sshd_config
-- sudo service ssh restart

### Configure Firewall
### Scripts
### Web server && SSL
### Deployment

```bash
$> git clone https://github.com/nicolasvienot/fractol.git Fractol
```

### Compiling

```bash
$> make
```

### Running

```bash
$> ./fractol [fractal name]
```

