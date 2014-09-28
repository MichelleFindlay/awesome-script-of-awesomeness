#!/bin/bash

#Loop for Script
COUNTER=0
while [  $COUNTER -lt 10 ]; do
clear
echo Awesome Script of Awesomeness for Redhat/CentOS Servers 
echo
echo Version 0.1b
echo See change log at: https://github.com/MichaelFindlay/script-of-awesomeness
echo Source available at: https://github.com/MichaelFindlay/script-of-awesomeness
echo
echo Written by Michael Findlay
echo
echo To exit back to menu options select Control + X at the same time
echo
PS3='Please enter your choice: '
options=("Check Raid" "Check HDD Space" "Free Memory" "Retrieve Plesk 9 Password" "Retrieve Plesk 10 Password" "Repair Plesk Database" "Qmail Stats" "Postfix Stats" "Remove Extra Plesk Languages" "Show Command History" "Fix Health Monitor" "Remove Dr Web (Will Reboot Plesk)" "Switch to Qmail MTA" "Switch to Postfix MTA" "Show All Litening TCP/UDP Ports" "Reconfigure all domains (Plesk 9)" "Reconfigure all domains (Plesk 10)" "Stop Firewall" "Start Firewall" "Show Directory Usage" "Services Management (Restart)" "Quit")
select opt in "${options[@]}"

do
    case $opt in
        "Check Raid")
            watch -n 1 'cat /proc/mdstat'

            ;;
        "Check HDD Space")
            watch -n 1 'df -h'

            ;;
        "Free Memory")
            watch -n 1 'free -m'

            ;;
        "Retrieve Plesk 9 Password")
	    watch -n 1 'cat /etc/psa/.psa.shadow'

            ;;
        "Retrieve Plesk 10 Password")
            watch -n 1 '/usr/local/psa/bin/admin --show-password'

	 ;;
        "Repair Plesk Database")
            mysqlcheck -uadmin -p`cat /etc/psa/.psa.shadow ` psa -r

 ;;
        "Qmail Stats")
            watch -n 1 '/var/qmail/bin/qmail-qstat'

;;
        "Postfix Stats")
            watch -n 1 'postqueue -p'

;;
        "Remove Extra Plesk Languages")
clear
echo If you get an errors this means it is not installed.
echo

echo Italian Removal
/usr/local/psa/admin/bin/localemng --remove --locale=it-IT
echo

echo German Removal
/usr/local/psa/admin/bin/localemng --remove --locale=de-DE
echo

echo US removal
/usr/local/psa/admin/bin/localemng --remove --locale=en-US
echo

echo Spanish Removal
/usr/local/psa/admin/bin/localemng --remove --locale=es-ES
echo

echo Japanese removal
/usr/local/psa/admin/bin/localemng --remove --locale=ja-JP
echo

echo Netherlands Removal
/usr/local/psa/admin/bin/localemng --remove --locale=nl-NL
echo

echo Polish removal
/usr/local/psa/admin/bin/localemng --remove --locale=pl-PL
echo

echo Russian removal
/usr/local/psa/admin/bin/localemng --remove --locale=ru-RU
echo

echo Chinese removal
/usr/local/psa/admin/bin/localemng --remove --locale=zh-CN
echo

echo Tiwan removal
/usr/local/psa/admin/bin/localemng --remove --locale=zh-TW
echo

echo Frence removal
/usr/local/psa/admin/bin/localemng --remove --locale=fr-FR
echo

;;
        "Fix Health Monitor")
/usr/local/psa/bin/sw-engine-pleskrun /usr/local/psa/admin/plib/scripts/setup-health-monitor.php

;;
        "Show Command History")
history | less

;;
        "Switch to Postfix MTA")
/usr/local/psa/admin/sbin/autoinstaller --select-release-current --install-component postfix

;;
        "Switch to Qmail MTA")
/usr/local/psa/admin/sbin/autoinstaller --select-release-current --install-component qmail

;;
        "Remove Dr Web (Will Reboot Plesk)")
yum remove drweb-base drweb-bases drweb-common drweb-daemon drweb-updater psa-drweb-configurator && service psa restart

;;
        "Reconfigure all domains (Plesk 9)")
/usr/local/psa/admin/sbin/websrvmng --reconfigure-all

;;
        "Reconfigure all domains (Plesk 10)")
/usr/local/psa/admin/sbin/httpdmng --reconfigure-all

;;
        "Show All Litening TCP/UDP Ports")
netstat -tulpn

;;
        "Stop Firewall")
service iptables stop

;;
        "Start Firewall")
service iptables start

;;
        "Show Directory Usage")
du -h --max-depth=1 /

;;
	"Services Management (Restart)")
showMenu () {
clear
echo "Enter the number listed below to restart the service."
echo 
echo "1) Web Server"
echo "2) Plesk Server"
echo "3) MySQL"
echo "4) Qmail"
echo "5) Postfix"
echo "6) DNS Server"
echo "7) FTP Server"
echo "8) SSH Server"
echo "9) Exit to previous menu"
} 

while [ 1 ]
do
showMenu
read CHOICE
case "$CHOICE" in
"1")
service httpd restart
sleep 8

;;
"2")
service psa restart && server sw-cp-server
sleep 8

;;
"3")
service mysqld restart
sleep 8

;;
"4")
service qmail restart
sleep 8

;;
"5")
service postfix restart
sleep 8

;;
"6")
service named restart
sleep 8

;;
"7")
service xinetd restart
sleep 8

;;
"8")
service sshd restart
sleep 8

;;
"9")
break

;;
esac
done

            ;;
        "Quit")
            exit

            ;;
        *) echo invalid option;;
    esac
done
done
