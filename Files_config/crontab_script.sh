#!/bin/bash
cat /etc/crontab > /home/nico/crontab_save/new
DIFF=$(diff /home/nico/crontab_save/new /home/nico/crontab_save/crontab)
if [ "$DIFF" != "" ]; then
	sudo echo "Crontab has changed, sending mail"
	sudo sendmail nvienot@student.42.fr < /home/nico/mail/mail_crontab.txt
	sudo rm -rf /home/nico/crontab_save/crontab
	sudo mv /home/nico/crontab_save/new /home/nico/crontab_save/crontab
	sudo rm -rf /home/nico/crontab_save/new
fi