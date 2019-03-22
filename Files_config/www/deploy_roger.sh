#!/bin/bash

if [ $# -eq 0 ]; then

	echo "Usage:"
	echo "./deploy_roger.sh \"Commit message"\"

	exit 1
fi

if [ $# -eq 1 ]; then
	git add .
	git commit -m "$1"
	git push
	echo "Git repository updated. Now running update on server."
	ssh nico@10.12.124.124 -p 55555 "/home/nico/scripts/update_server.sh"
	exit 0
fi

exit 1