#!/bin/bash

## Written by @AZ Anonymous AKA aziz199505@gmail.com
## SSH FILTER


#SSH_LOG FILE

SSH_LOG=/var/log/secure

#TEMP FILES
SSH_TEMP=/tmp/sshdFilter.$$
FAILED_LOG=/tmp/sshFail.$$
FAILED_IP=/tmp/sshIP.$$
IP_COUNT=/tmp/IPcount.$$
MONTH=/tmp/month.$$
DAY=/tmp/day.$$
MoDa=/tmp/moda.$$
ALL=/tmp/all.$$
COUNT=/tmp/count.$$

del_trap()
{
	echo ""
	echo "***********CTRL-C Pressed! Deleting Temporary file*******************"
	rm -rf /tmp/sshdFilter.$$
	rm -rf /tmp/sshFail.$$
	rm -rf /tmp/sshIP.$$
	rm -rf /tmp/IPcount.$$
	rm -rf /tmp/month.$$
	rm -rf /tmp/day.$$
	rm -rf /tmp/moda.$$
	rm -rf /tmp/all.$$
	rm -rf /tmp/count.$$
	rm -rf /root/noip*
	exit 1

}

trap del_trap 2	



while :
do
	
	grep "ssh" $SSH_LOG > $SSH_TEMP
	grep "Failed" $SSH_TEMP > $FAILED_LOG
	grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $FAILED_LOG > $FAILED_IP
	grep -o "^[A-Z][a-z][a-z]" $FAILED_LOG > $MONTH
	grep -o  " [0-9][0-9] " $FAILED_LOG > $DAY	
	paste $MONTH $DAY > $MoDa
	paste $MoDa $FAILED_IP > $ALL

	cat $ALL | uniq -c > $COUNT
	
	cat $COUNT
	awk -f ssh.awk $COUNT
	

        sleep 1
done
