#!/bin/bash

cat /etc/crontab > /home/nico/crontab_save/new

DIFF=$(diff /home/nico/crontab_save/new /home/nico/crontab_save/crontab)

if [ "$DIFF" != "" ]; then
	echo "Crontab has changed, sending mail!"
	sudo sendmail nvienot@student.42.fr < /home/nico/mail/mail_crontab.txt
	rm /home/nico/crontab_save/crontab
	mv /home/nico/crontab_save/new /home/nico/crontab_save/crontab
else
	echo "No changes on crontab!"
fi

exit 0