#! /bin/bash
# Programming and idea by : E2MA3N [Iman Homayouni]
# Gitbub : https://github.com/e2ma3n
# Email : e2ma3n@Gmail.com
# Website : http://OSLearn.ir
# License : GPL v3.0
# M.SAL v1.0 - Installer [Monitor. System Authentication Logs]
# --------------------------------------------------------------- #

# check root privilege
[ "`whoami`" != "root" ] && echo '[-] Please use root user or sudo' && exit 1

# help function
function help_f {
	echo 'Usage: '
	echo '	sudo ./install.sh -i [install program]'
	echo '	sudo ./install.sh -u [help to uninstall program]'
	echo '	sudo ./install.sh -c [check dependencies]'
}

# uninstall program from system
function uninstall_f {
	echo 'For uninstall program:'
	echo '	sudo rm -rf /opt/M.SAL_v1.0/'
}

# check dependencies in system
function check_f {
	echo '[+] check dependencies in system:  '
	for program in whoami sleep cat head tail cut awk date grep mv cp rm
	do
		if [ ! -z `which $program 2> /dev/null` ] ; then
			echo "[+] $program found"
		else
			echo "[-] Error: $program not found"
		fi
		sleep 0.5
	done
}

function up {
	awk -v line=$1 -v new_content="$2" '{
		if (NR == line) {
				print new_content;
		} else {
				print $0;
		}
	}' $3
}

# install program in system
function install_f {

	# print header
	sleep 1.5
	echo '[+] Monitor. System Authentication Logs [M.SAL v1.0]'
	sleep 1.5
	echo '[+] Debian Edition'
	sleep 1.5
	echo '[+] Tested on all versions of debian 6, debian 7 and debian 8'
	sleep 1.5
	echo -en '[+] Press enter for continue or press ctrl+c for exit' ; read
	sleep 2

	# Create main directory
	echo '[+]'
	[ ! -d /opt/M.SAL_v1.0/ ] && mkdir -p /opt/M.SAL_v1.0/ && echo '[+] Main Directory created' || echo '[-] Error: /opt/M.SAL_v1.0/ exist'
	sleep 1

	# Create index directory
	[ ! -d /opt/M.SAL_v1.0/index ] && mkdir -p /opt/M.SAL_v1.0/index && echo '[+] Index Directory created' || echo '[-] Error: /opt/M.SAL_v1.0/index exist'
	sleep 1

	# Create ssh_attack directory
	[ ! -d /opt/M.SAL_v1.0/ssh_attack ] && mkdir -p /opt/M.SAL_v1.0/ssh_attack && echo '[+] ssh_attack Directory created' || echo '[-] Error: /opt/M.SAL_v1.0/ssh_attack exist'
	sleep 1

	# Create ssh_login directory
	[ ! -d /opt/M.SAL_v1.0/ssh_login ] && mkdir -p /opt/M.SAL_v1.0/ssh_login && echo '[+] ssh_login Directory created' || echo '[-] Error: /opt/M.SAL_v1.0/ssh_login exist'
	sleep 1

	# Create su_attack directory
	[ ! -d /opt/M.SAL_v1.0/su_attack ] && mkdir -p /opt/M.SAL_v1.0/su_attack && echo '[+] su_attack Directory created' || echo '[-] Error: /opt/M.SAL_v1.0/su_attack exist'
	sleep 1

	# Create su_login directory
	[ ! -d /opt/M.SAL_v1.0/su_login ] && mkdir -p /opt/M.SAL_v1.0/su_login && echo '[+] su_login Directory created' || echo '[-] Error: /opt/M.SAL_v1.0/su_login exist'
	sleep 1

	# Insert web server directory
	for (( ;; )) ; do
		echo '[+] Enter web server directory. For example, /var/www/html'
		echo -en "[+] Enter address : " ; read www
		echo -en "[+] Your web server directory is $www . Are you sure ? [y/n] : " ; read question
		if [ "$question" = "y" ] ; then
			break
		else
			echo '[+]'
		fi
	done

	# Insert web server directory to 'M.SAL.sh'
	up 11 "www=$www" M.SAL.sh > M.SAL_new.sh
	mv M.SAL_new.sh M.SAL.sh

	# Delay
	echo -en '[+] Delay between each check [by Second] : ' ; read delay
	up 217 "sleep $delay" M.SAL.sh > M.SAL_new.sh
	mv M.SAL_new.sh M.SAL.sh

	# Create css directory in web server
	[ ! -d $www/M.SAL/css ] && mkdir -p $www/M.SAL/css && echo "[+] M.SAL/css Directory created in $www" || echo "[-] Error: $www/M.SAL/css exist"
	sleep 1

	# Copy normalize.css and style.css in web server
	echo '[+]'
	[ ! -f $www/M.SAL/css/style.css ] && cp style.css $www/M.SAL/css/ && chmod 644 $www/M.SAL/css/style.css && echo '[+] style.css copied' || echo "[-] Error: $www/M.SAL/css/style.css exist"
	[ ! -f $www/M.SAL/css/normalize.css ] && cp normalize.css $www/M.SAL/css/ && chmod 644 $www/M.SAL/css/normalize.css && echo '[+] normalize.css copied' || echo "[-] Error: $www/M.SAL/css/normalize.css exist"
	sleep 1

	# Copy index.html
	echo '[+]'
	[ ! -f /opt/M.SAL_v1.0/index/index_part1.html ] && cp index_part1.html /opt/M.SAL_v1.0/index/ && chmod 644 /opt/M.SAL_v1.0/index/index_part1.html && echo '[+] index_part1.html copied' || echo '[-] Error: /opt/M.SAL_v1.0/index/index_part1.html exist'
	[ ! -f /opt/M.SAL_v1.0/index/index_part3.html ] && cp index_part3.html /opt/M.SAL_v1.0/index/ && chmod 644 /opt/M.SAL_v1.0/index/index_part3.html && echo '[+] index_part3.html copied' || echo '[-] Error: /opt/M.SAL_v1.0/index/index_part3.html exist'
	sleep 1

	# Copy ssh_attack.html
	echo '[+]'
	[ ! -f /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part1.html ] && cp ssh_attack_part1.html /opt/M.SAL_v1.0/ssh_attack/ && chmod 644 /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part1.html && echo '[+] ssh_attack_part1.html copied' || echo '[-] Error: /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part1.html exist'
	[ ! -f /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part3.html ] && cp ssh_attack_part3.html /opt/M.SAL_v1.0/ssh_attack/ && chmod 644 /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part3.html && echo '[+] ssh_attack_part3.html copied' || echo '[-] Error: /opt/M.SAL_v1.0/ssh_attack/ssh_attack_part3.html exist'
	sleep 1

	# Copy ssh_login.html
	echo '[+]'
	[ ! -f /opt/M.SAL_v1.0/ssh_login/ssh_login_part1.html ] && cp ssh_login_part1.html /opt/M.SAL_v1.0/ssh_login/ && chmod 644 /opt/M.SAL_v1.0/ssh_login/ssh_login_part1.html && echo '[+] ssh_login_part1.html copied' || echo '[-] Error: /opt/M.SAL_v1.0/ssh_login/ssh_login_part1.html exist'
	[ ! -f /opt/M.SAL_v1.0/ssh_login/ssh_login_part3.html ] && cp ssh_login_part3.html /opt/M.SAL_v1.0/ssh_login/ && chmod 644 /opt/M.SAL_v1.0/ssh_login/ssh_login_part3.html && echo '[+] ssh_login_part3.html copied' || echo '[-] Error: /opt/M.SAL_v1.0/ssh_login/ssh_login_part3.html exist'
	sleep 1

	# Copy su_attack.html
	echo '[+]'
	[ ! -f /opt/M.SAL_v1.0/su_attack/su_attack_part1.html ] && cp su_attack_part1.html /opt/M.SAL_v1.0/su_attack/ && chmod 644 /opt/M.SAL_v1.0/su_attack/su_attack_part1.html && echo '[+] su_attack_part1.html copied' || echo '[-] Error: /opt/M.SAL_v1.0/su_attack/su_attack_part1.html exist'
	[ ! -f /opt/M.SAL_v1.0/su_attack/su_attack_part3.html ] && cp su_attack_part3.html /opt/M.SAL_v1.0/su_attack/ && chmod 644 /opt/M.SAL_v1.0/su_attack/su_attack_part3.html && echo '[+] su_attack_part3.html copied' || echo '[-] Error: /opt/M.SAL_v1.0/su_attack/su_attack_part3.html exist'
	sleep 1

	# Copy su_login.html
	echo '[+]'
	[ ! -f /opt/M.SAL_v1.0/su_login/su_login_part1.html ] && cp su_login_part1.html /opt/M.SAL_v1.0/su_login/ && chmod 644 /opt/M.SAL_v1.0/su_login/su_login_part1.html && echo '[+] su_login_part1.html copied' || echo '[-] Error: /opt/M.SAL_v1.0/su_login/su_login_part1.html exist'
	[ ! -f /opt/M.SAL_v1.0/su_login/su_login_part3.html ] && cp su_login_part3.html /opt/M.SAL_v1.0/su_login/ && chmod 644 /opt/M.SAL_v1.0/su_login/su_login_part3.html && echo '[+] su_login_part3.html copied' || echo '[-] Error: /opt/M.SAL_v1.0/su_login/su_login_part3.html exist'
	sleep 1

	# Copy M.SAL.sh
	echo '[+]'
	[ ! -f /opt/M.SAL_v1.0/M.SAL.sh ] && cp M.SAL.sh /opt/M.SAL_v1.0/ && chmod 755 /opt/M.SAL_v1.0/M.SAL.sh && echo '[+] M.SAL.sh copied' || echo '[-] Error: /opt/M.SAL_v1.0/M.SAL.sh exist'
	sleep 1

	# Copy README
	[ ! -f /opt/M.SAL_v1.0/README ] && cp README /opt/M.SAL_v1.0/README && chmod 644 /opt/M.SAL_v1.0/README && echo '[+] README copied' || echo '[-] Error: /opt/M.SAL_v1.0/README exist'
	sleep 1

	# echo footer
	echo '[+] Please see README'
	sleep 0.5
	echo '[!] Warning: You have two choises, start manually or starting up script as a daemon'
	sleep 0.5
	echo '[!] Warning: You should run program as root'
	sleep 0.5
	echo '[+] You can run program from /opt/M.SAL_v1.0/M.SAL.sh'
	echo '[+] Done'
}

case $1 in
	-i) install_f ;;
	-c) check_f ;;
	-u) uninstall_f ;;
	*) help_f ;;
esac
