BEGIN {
}

{
count = $1
month = $2
day = $3
ip = $4
if ( count >= 3 )
{
	iptable = "iptables -I INPUT --source " ip " -j REJECT"  
	save = "service iptables save"
	restart = "service iptables restart"
	#cleanLog= "echo '' > /var/log/secure"
	noip = "sed s/" ip "//g /var/log/secure > /root/noip"
	noipmonth =  "sed s/" month "//g /root/noip > /root/noipmonth"
	noipmonthday =  "sed s/" day "//g /root/noipmonth > /root/noipmonthday"
	changelog = "cat /root/noipmonthday > /var/log/secure"
	system(iptable)
	system(save)
	system(restart)

	system(noip)
	system(noipmonth)
	system(noipmonthday)
	system(changelog)
}

}

END{
}

