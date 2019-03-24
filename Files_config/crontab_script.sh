#!/bin/bash

cat /etc/crontab > /home/xxx/crontab_save/new

DIFF=$(diff /home/xxx/crontab_save/new /home/xxx/crontab_save/crontab)

if [ "$DIFF" != "" ]; then
	echo "Crontab has changed, sending mail!"
	sudo sendmail nvienot@student.42.fr < /home/xxx/mail/mail_crontab.txt
	rm /home/xxx/crontab_save/crontab
	mv /home/xxx/crontab_save/new /home/xxx/crontab_save/crontab
else
	echo "No changes on crontab!"
fi

exit 0