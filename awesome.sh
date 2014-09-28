#!/bin/bash

# ----------------------------------
# Step #2: Functions
# ----------------------------------
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}
 
one(){
	echo "one() called"
        pause
}
 
# do something in two()
two(){
	echo "two() called"
        pause
}
 
# function to display menus
show_menus() {
	clear
	echo "Awesome Script of Awesomeness for Redhat/CentOS Servers"
	echo ""
	echo "Version 0.1c"
	echo "See change log at: https://github.com/MichaelFindlay/awesome-script-of-awesomeness/blob/master/awesome.changelog.txt"
	echo "Source available at: https://github.com/MichaelFindlay/awesome-script-of-awesomeness/blob/master/awesome.sh"
	echo ""
	echo "Written by Michael Findlay"
	echo ""
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo " M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "Server Status			Plesk Management"
	echo "1. Check Raid Integrity		5. Retrieve Plesk Password"
	echo "2. Check HDD Space		6. Repair Plesk Database"
	echo "3. Memory Usage			"
	echo "3. Memory Usage			"
	echo "4. Show Directory Usage		"
	echo ""
	echo "Plesk Tools			Firewall Management"
	echo "7. Update Health Monitor	12. Show All Listening TCP/UDP Ports"
	echo "8. Remove Dr Web		13. Start IPv4 Firewall"
	echo "9. Remove Extra Languages	14. Stop IPv4 Firewall"
	echo "10. Show Command History	15. Start IPv6 Firewall"
	echo "11. Reconfigure all domains	16. Stop IPv6 Firewall"
	echo ""

	echo "Services Management		Mail Transport Management"
	echo "17. Web Server			31. Qmail Status"
	echo "18. Plesk Server		32. Postfix Status"
	echo "19. MySQL"
	echo "20. Qmail			33. Switch to Qmail (SMTP, POP)"
	echo "21. Postfix			34. Switch to Postfix (SMTP, POP)"
	echo "22. PostgreSQL			35. Enable Dovecot (IMAP, POP"
	echo "23. Fail2Ban"
	echo "24. Courier"
	echo "25. Mailman"
	echo "26. Tomcat"
	echo "27. NTP"
	echo "28. DNS Server"
	echo "29. FTP Server"
	echo "30. SSH Server			99. Quit"
}
# read input from the keyboard and take a action
# invoke the one() when the user select 1 from the menu option.
# invoke the two() when the user select 2 from the menu option.
# Exit when user the user select 3 form the menu option.
read_options(){
	local choice
	read -p "Enter choice [ 1 - 35] " choice
	case $choice in
		1) watch -n 1 'cat /proc/mdstat' ;;
		# Will show the current status of the raid array.
			
		2) watch -n 1 'df -h' ;;
		# Output showing the available space on your partitions.            
		
		3) watch -n 1 'df -h' ;;
		# Output showing the available space on your partitions.
			
		4) du -h --max-depth=1 / ;;
		# Shows you the directory usage from "/"
			
		5) watch -n 1 '/usr/local/psa/bin/admin --show-password' ;;
		# Will show you your plesk password if you have forgotten it.
			
		6) mysqlcheck -uadmin -p`cat /etc/psa/.psa.shadow ` psa -r ;;
		# Will request the server performs a repair on the plesk database.
		
		7) /usr/local/psa/bin/sw-engine-pleskrun /usr/local/psa/admin/plib/scripts/setup-health-monitor.php ;;
		# This command can update the health monitor and refresh it to correct any errors.
		
		8) rpm -e drweb-updater drweb-common drweb-bases drweb-base drweb-daemon psa-drweb-configurator && service psa restart && /usr/local/psa/admin/sbin/mchk --without-spam && rm -rf /var/spool/cron/drweb && rm -rf /etc/cron.daily/drweb-update && /usr/local/psa/admin/bin/modules/watchdog/wd --unmonit-service=drweb;;
		# This command will remove dr web from your Plesk server.
		
		9) 	clear
		echo If any errors appear whilst this is running that language pack is not installed on your server.
		echo

		echo Italian language pack removal
			/usr/local/psa/admin/bin/localemng --remove --locale=it-IT
		echo

		echo German  language pack removal
			/usr/local/psa/admin/bin/localemng --remove --locale=de-DE
		echo

		echo Spanish language pack removal
			/usr/local/psa/admin/bin/localemng --remove --locale=es-ES
		echo

		echo Japanese language pack removal
			/usr/local/psa/admin/bin/localemng --remove --locale=ja-JP
		echo

		echo Netherlands language pack removal
			/usr/local/psa/admin/bin/localemng --remove --locale=nl-NL
		echo

		echo Polish language pack removal
			/usr/local/psa/admin/bin/localemng --remove --locale=pl-PL
		echo

		echo Russian language pack removal
			/usr/local/psa/admin/bin/localemng --remove --locale=ru-RU
		echo

		echo Chinese language pack removal
			/usr/local/psa/admin/bin/localemng --remove --locale=zh-CN
		echo

		echo Tiwan language pack removal
			/usr/local/psa/admin/bin/localemng --remove --locale=zh-TW
		echo

		echo Frence language pack removal
			/usr/local/psa/admin/bin/localemng --remove --locale=fr-FR
		echo
	;;
	# Performs a removal of non US and UK 
	
		9) history | less ;;
		# Will show you an output of the commands ran on the shell user.
		
		10) /usr/local/psa/admin/sbin/httpdmng --reconfigure-all ;;
		# This command will reconfigure the Apache for all domains on the server.
		
		11) /usr/local/psa/admin/sbin/httpdmng --reconfigure-all ;;
		# This command will reconfigure the Apache for all domains on the server.
		
		12) netstat -tulpn ;;
		# This will show you all listening TCP and UDP ports on the server
		
		13) service iptables start ;;
		# Starts your firewall from a stopped state.
		
		14) service iptables stop ;;
		# Stops your firewall from a running state.
		
		15) service ip6tables start ;;
		# Starts your ipv6 firewall from a stopped state.
		
		16) service ip6tables stop ;;
		# Stops your ipv6 firewall from a running state.
		
		17) service httpd restart ;;
		# Restarts the web server.
		
		18) service psa restart && server sw-cp-server ;;
		# Restarts the plesk servers.
		
		19) service mysqld restart ;;
		# Restarts the mysql server.
		
		20) service qmail restart ;;
		# Restarts the qmail server.
		
		21) service postfix restart ;;
		# Restarts the postix server.
		
		22) service postgresql restart ;;
		# Restarts the postgresql server.
		
		23) service fail2ban restart ;;
		# Restarts the fail2ban service.
		
		24) service courier-imapd restart && service courier-imaps restart && service courier-pop3d restart && service courier-pop3s restart ;;
		# Restarts the imap & pop3 service.
		
		25) service mailman restart ;;
		# Restarts the mailman service.
		
		26) service tomcat6 restart ;;
		# Restarts the mailman service.
		
		26) service ntpd restart ;;
		# Restarts the ntp service.
		
		27) service named restart ;;
		# Restarts the dns service.
		
		27) service xinetd restart ;;
		# Restarts the ftp service.
		
		28) service sshd restart ;;
		# Restarts the ssh service.
		
		29) service sshd restart ;;
		# Restarts the ssh service.
		
		30) service sshd restart ;;
		# Restarts the ssh service.
		
		31) watch -n 1 '/var/qmail/bin/qmail-qstat' ;;
		# Will show you the servers Qmail service statistics.
		
		32) watch -n 1 'postqueue -p' ;;
		# Shows on a 1 second reload the queue status of Postfix.
		
		33) /usr/local/psa/admin/sbin/autoinstaller --select-release-current --install-component qmail ;;
		# Switches your mail transport agent to Qmail.
		
		34) /usr/local/psa/admin/sbin/autoinstaller --select-release-current --install-component postfix ;;
		# Switches your mail transport agent to Postfix.
		
		35) /usr/local/psa/admin/sbin/autoinstaller --select-release-current --install-component dovecot ;;
		# Enables the Dovecot IMAP server
		
		99) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}
 
# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP
 
# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
 
	show_menus
	read_options
done

