#! /bin/bash
# Programming and idea by : E2MA3N [Iman Homayouni]
# Gitbub : https://github.com/e2ma3n
# Email : e2ma3n@Gmail.com
# Website : http://OSLearn.ir
# License : GPL v3.0
# M.SAL v1.0 - Core [Monitor. System Authentication Logs]
# --------------------------------------------------------------- #

# Web Server directory
www="/var/www/html"


# check root privilege
[ "`whoami`" != "root" ] && echo '[-] Please use root user or sudo' && exit 1

# check log file
[ ! -f /var/log/auth.log ] && echo '[-] /var/log/auth.log not found' && exit 1


function up {
	awk -v line=$1 -v new_content="$2" '{
		if (NR == line) {
				print new_content;
		} else {
				print $0;
		}
	}' $3
}


for (( ;; )) ; do

	update=`echo -n 'Last Update : ' ; date '+%d/%m/%Y - %H:%M:%S'`
	log_file=`cat $(ls /var/log/auth.log* | sort -r | grep -v gz) | tr -s ' '`

	# Master - SSH Login
	ssh_login=`echo "$log_file" | grep ssh2 | grep 'Accepted password for' | cut -d ' ' -f 1,2,3,9,11 | tac`
	if [ ! -z "$ssh_login" ] ; then

		# Add SSH Login to index.html
		echo '<tr>' >> /opt/M.SAL_v1.0/index/index_part2.html
		echo "<td data-title='Details'><a href='ssh_login.html'>SSH Login</a></td>" >> /opt/M.SAL_v1.0/index/index_part2.html
		echo "<td data-title='Descriptions'>Which user logged in to the server via ssh protocol? for see more detail click on 'SSH Login'</td>" >> /opt/M.SAL_v1.0/index/index_part2.html
		echo '</tr>' >> /opt/M.SAL_v1.0/index/index_part2.html


		# create ssh login page
		number=`echo "$ssh_login" | wc -l`
		for (( i=1 ; i <= $number ; i++ )) ; do
			Line=`echo "$ssh_login" | head -n $i | tail -n 1`
			IP=`echo "$Line" | cut -d ' ' -f 5`
			date=`echo "$Line" | cut -d ' ' -f 1,2,3`
			user=`echo "$Line" | cut -d ' ' -f 4`

			echo '<tr>' >> /opt/M.SAL_v1.0/ssh_login/ssh_login_part2.html
			echo "<td data-title='ID'>$i</td>" >> /opt/M.SAL_v1.0/ssh_login/ssh_login_part2.html
			echo "<td data-title='IP'>$IP</td>" >> /opt/M.SAL_v1.0/ssh_login/ssh_login_part2.html
			echo "<td data-title='Date'>$date</td>" >> /opt/M.SAL_v1.0/ssh_login/ssh_login_part2.html
			echo "<td data-title='User'>$user</td>" >> /opt/M.SAL_v1.0/ssh_login/ssh_login_part2.html
			echo '</tr>' >> /opt/M.SAL_v1.0/ssh_login/ssh_login_part2.html
		done

		up 6 "<p></p><font size="2">$update</font>" /opt/M.SAL_v1.0/ssh_login/ssh_login_part3.html > /tmp/M.SAL_page.html
		mv /tmp/M.SAL_page.html /opt/M.SAL_v1.0/ssh_login/ssh_login_part3.html

		cat /opt/M.SAL_v1.0/ssh_login/ssh_login_part1.html >> /opt/M.SAL_v1.0/ssh_login/ssh_login.html
		cat /opt/M.SAL_v1.0/ssh_login/ssh_login_part2.html >> /opt/M.SAL_v1.0/ssh_login/ssh_login.html
		cat /opt/M.SAL_v1.0/ssh_login/ssh_login_part3.html >> /opt/M.SAL_v1.0/ssh_login/ssh_login.html
		rm /opt/M.SAL_v1.0/ssh_login/ssh_login_part2.html &> /dev/null
		mv /opt/M.SAL_v1.0/ssh_login/ssh_login.html $www/M.SAL/ssh_login.html
		# END OF create ssh login page
	fi


	# Master - SSH Attack
	ssh_attack=`echo "$log_file" | grep ssh2 | grep 'Failed password for' | tac`
	if [ ! -z "$ssh_attack" ] ; then

		# Add SSH Attack to index.html
		echo '<tr>' >> /opt/M.SAL_v1.0/index/index_part2.html
		echo "<td data-title='Details'><a href='ssh_attack.html'>SSH Attack</a></td>" >> /opt/M.SAL_v1.0/index/index_part2.html
		echo "<td data-title='Descriptions'>For see which user was under attack and more detail, click on 'SSH Attack'</td>" >> /opt/M.SAL_v1.0/index/index_part2.html
		echo '</tr>' >> /opt/M.SAL_v1.0/index/index_part2.html


		# create ssh attack page
		number=`echo "$ssh_attack" | wc -l`
		for (( i=1 ; i <= $number ; i++ )) ; do
			Line=`echo "$ssh_attack" | head -n $i | tail -n 1`
			echo "$Line" | grep 'invalid user' &> /dev/null
			if [ "$?" = "0" ] ; then
				IP=`echo "$Line" | cut -d ' ' -f 13`
				date=`echo "$Line" | cut -d ' ' -f 1,2,3`
				user=`echo "$Line" | cut -d ' ' -f 9,11`
			else
				IP=`echo "$Line" | cut -d ' ' -f 11`
				date=`echo "$Line" | cut -d ' ' -f 1,2,3`
				user=`echo "$Line" | cut -d ' ' -f 9`
			fi

			echo '<tr>' >> /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part2.html
			echo "<td data-title='ID'>$i</td>" >> /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part2.html
			echo "<td data-title='IP'>$IP</td>" >> /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part2.html
			echo "<td data-title='Date'>$date</td>" >> /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part2.html
			echo "<td data-title='User'>$user</td>" >> /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part2.html
			echo '</tr>' >> /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part2.html
		done

		up 6 "<p></p><font size="2">$update</font>" /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part3.html > /tmp/M.SAL_page.html
		mv /tmp/M.SAL_page.html /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part3.html

		cat /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part1.html >> /opt/M.SAL_v1.0/ssh_attack/ssh_attack.html
		cat /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part2.html >> /opt/M.SAL_v1.0/ssh_attack/ssh_attack.html
		cat /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part3.html >> /opt/M.SAL_v1.0/ssh_attack/ssh_attack.html
		rm /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part2.html &> /dev/null
		mv /opt/M.SAL_v1.0/ssh_attack/ssh_attack.html $www/M.SAL/ssh_attack.html
		# END OF create ssh attack page
	fi


	# MASTER - SU Login
	su_login=`echo "$log_file" | grep "\sSuccessful su for\s" | cut -d ' ' -f 1,2,3,6,7,8,9,10,11 | tac`
	if [ ! -z "$su_login" ] ; then

		# Add SU Login to index.html
		echo '<tr>' >> /opt/M.SAL_v1.0/index/index_part2.html
		echo "<td data-title='Details'><a href='su_login.html'>SU Login</a></td>" >> /opt/M.SAL_v1.0/index/index_part2.html
		echo "<td data-title='Descriptions'>You can see which user use 'su' command. for see more detail click on 'SU Login'</td>" >> /opt/M.SAL_v1.0/index/index_part2.html
		echo '</tr>' >> /opt/M.SAL_v1.0/index/index_part2.html

		# create SU login page
		number=`echo "$su_login" | wc -l`
		for (( i=1 ; i <= $number ; i++ )) ; do
			Line=`echo "$su_login" | head -n $i | tail -n 1`
			user=`echo "$Line" | cut -d ' ' -f 9`
			date=`echo "$Line" | cut -d ' ' -f 1,2,3`
			login_to=`echo "$Line" | cut -d ' ' -f 7`

			echo '<tr>' >> /opt/M.SAL_v1.0/su_login/su_login_part2.html
			echo "<td data-title='ID'>$i</td>" >> /opt/M.SAL_v1.0/su_login/su_login_part2.html
			echo "<td data-title='User'>$user</td>" >> /opt/M.SAL_v1.0/su_login/su_login_part2.html
			echo "<td data-title='Date'>$date</td>" >> /opt/M.SAL_v1.0/su_login/su_login_part2.html
			echo "<td data-title='Login to'>$login_to</td>" >> /opt/M.SAL_v1.0/su_login/su_login_part2.html
			echo '</tr>' >> /opt/M.SAL_v1.0/su_login/su_login_part2.html
		done

		up 6 "<p></p><font size="2">$update</font>" /opt/M.SAL_v1.0/su_login/su_login_part3.html > /tmp/M.SAL_page.html
		mv /tmp/M.SAL_page.html /opt/M.SAL_v1.0/su_login/su_login_part3.html

		cat /opt/M.SAL_v1.0/su_login/su_login_part1.html >> /opt/M.SAL_v1.0/su_login/su_login.html
		cat /opt/M.SAL_v1.0/su_login/su_login_part2.html >> /opt/M.SAL_v1.0/su_login/su_login.html
		cat /opt/M.SAL_v1.0/su_login/su_login_part3.html >> /opt/M.SAL_v1.0/su_login/su_login.html
		rm /opt/M.SAL_v1.0/su_login/su_login_part2.html &> /dev/null
		mv /opt/M.SAL_v1.0/su_login/su_login.html $www/M.SAL/su_login.html
		# END OF create SU login page
	fi


	# MASTER - SU Attack
	su_attack=`echo "$log_file" | grep "\sFAILED su for\s" | cut -d ' ' -f 1,2,3,6,7,8,9,10,11 | tac`
	if [ ! -z "$su_attack" ] ; then

		# Add SU Attack to index.html
		echo '<tr>' >> /opt/M.SAL_v1.0/index/index_part2.html
		echo "<td data-title='Details'><a href='su_attack.html'>SU Attack</a></td>" >> /opt/M.SAL_v1.0/index/index_part2.html
		echo "<td data-title='Descriptions'>Some time Some users try to finding other user's password ! you can see this occurrence by click on 'SU Attack'</td>" >> /opt/M.SAL_v1.0/index/index_part2.html
		echo '</tr>' >> /opt/M.SAL_v1.0/index/index_part2.html


		# create SU Attack page
		number=`echo "$su_attack" | wc -l`
		for (( i=1 ; i <= $number ; i++ )) ; do
			Line=`echo "$su_attack" | head -n $i | tail -n 1`
			user=`echo "$Line" | cut -d ' ' -f 9`
			date=`echo "$Line" | cut -d ' ' -f 1,2,3`
			login_to=`echo "$Line" | cut -d ' ' -f 7`

			echo '<tr>' >> /opt/M.SAL_v1.0/su_attack/su_attack_part2.html
			echo "<td data-title='ID'>$i</td>" >> /opt/M.SAL_v1.0/su_attack/su_attack_part2.html
			echo "<td data-title='User'>$user</td>" >> /opt/M.SAL_v1.0/su_attack/su_attack_part2.html
			echo "<td data-title='Date'>$date</td>" >> /opt/M.SAL_v1.0/su_attack/su_attack_part2.html
			echo "<td data-title='Login to'>$login_to</td>" >> /opt/M.SAL_v1.0/su_attack/su_attack_part2.html
			echo '</tr>' >> /opt/M.SAL_v1.0/su_attack/su_attack_part2.html
		done

		up 6 "<p></p><font size="2">$update</font>" /opt/M.SAL_v1.0/su_attack/su_attack_part3.html > /tmp/M.SAL_page.html
		mv /tmp/M.SAL_page.html /opt/M.SAL_v1.0/su_attack/su_attack_part3.html

		cat /opt/M.SAL_v1.0/su_attack/su_attack_part1.html >> /opt/M.SAL_v1.0/su_attack/su_attack.html
		cat /opt/M.SAL_v1.0/su_attack/su_attack_part2.html >> /opt/M.SAL_v1.0/su_attack/su_attack.html
		cat /opt/M.SAL_v1.0/su_attack/su_attack_part3.html >> /opt/M.SAL_v1.0/su_attack/su_attack.html
		rm /opt/M.SAL_v1.0/su_attack/su_attack_part2.html &> /dev/null
		mv /opt/M.SAL_v1.0/su_attack/su_attack.html $www/M.SAL/su_attack.html
		# END OF create SU Attack page
	fi

	# MASTER - E2MA3N GitHub
	echo '<tr>' >> /opt/M.SAL_v1.0/index/index_part2.html
	echo "<td data-title='Details'><a href='https://github.com/e2ma3n'>My Github</a></td>" >> /opt/M.SAL_v1.0/index/index_part2.html
	echo "<td data-title='Descriptions'>Please check my github account for see more programs</td>" >> /opt/M.SAL_v1.0/index/index_part2.html
	echo '</tr>' >> /opt/M.SAL_v1.0/index/index_part2.html

	# UPDATE time and date in Index.html
	up 6 "<p></p><font size="2">$update</font>" /opt/M.SAL_v1.0/index/index_part3.html > /tmp/M.SAL_index.html
	mv /tmp/M.SAL_index.html /opt/M.SAL_v1.0/index/index_part3.html

	# Move Index.html to Web server
	cat /opt/M.SAL_v1.0/index/index_part1.html >> /opt/M.SAL_v1.0/index/index.html
	cat /opt/M.SAL_v1.0/index/index_part2.html >> /opt/M.SAL_v1.0/index/index.html
	cat /opt/M.SAL_v1.0/index/index_part3.html >> /opt/M.SAL_v1.0/index/index.html
	rm /opt/M.SAL_v1.0/index/index_part2.html &> /dev/null
	mv /opt/M.SAL_v1.0/index/index.html $www/M.SAL/index.html

	# delay
	echo 'sleep'
	sleep 600

done
