#! /bin/bash
# Programming and idea by : E2MA3N [Iman Homayouni]
# Gitbub : https://github.com/e2ma3n
# Email : e2ma3n@Gmail.com
# Website : http://OSLearn.ir
# License : GPL v3.0
# sshc v5.0 - installer [SSH Management Console]
#--------------------------------------------------------#

# check root privilege
[ "`whoami`" != "root" ] && echo -e '[-] Please use root user or sudo' && exit 1


# help function
function help_f {
	echo "Usage: "
	echo "	sudo ./install.sh -i [install program]"
	echo '	sudo ./install.sh -u [help to uninstall program]'
	echo "	sudo ./install.sh -c [check dependencies]"
}


# install program on system
function install_f {
	[ ! -d /opt/sshc_v5/ ] && mkdir -p /opt/sshc_v5/ && echo "[+] Directory created" || echo "[-] Error: /opt/sshc_v5/ exist"
	sleep 1
	[ ! -f /opt/sshc_v5/sshc.sh ] && cp sshc.sh /opt/sshc_v5/ && chmod 755 /opt/sshc_v5/sshc.sh && echo "[+] sshc.sh copied" || echo "[-] Error: /opt/sshc_v5/sshc.sh exist"
	sleep 1
	[ ! -f /opt/sshc_v5/sshc.database.en ] && cp sshc.database.en /opt/sshc_v5/sshc.database.en && chown root:root /opt/sshc_v5/sshc.database.en && chmod 700 /opt/sshc_v5/sshc.database.en && echo "[+] sshc.database.en copied" || echo "[-] Error: /opt/sshc_v5/sshc.database.en exist"
	sleep 1
	[ -f /opt/sshc_v5/sshc.sh ] && ln -s /opt/sshc_v5/sshc.sh /usr/bin/sshc && echo "[+] symbolic link created" || echo "[-] Error: symbolic link not created"
	sleep 1
	[ ! -f /opt/sshc_v5/README ] && cp README /opt/sshc_v5/README && chmod 644 /opt/sshc_v5/README && echo "[+] README copied" || echo "[-] Error: /opt/sshc_v5/README exist"
	sleep 1

	echo "[+] Please see README"
	sleep 0.5
	echo "[!] Warning: run program and edit your database."
	sleep 0.5
	echo "[!] Warning: defaul password is 'sshc'"
	sleep 0.5
	echo "[+] Done"
}


# uninstall program from system
function uninstall_f {
	echo 'For uninstall program:'
	echo '	sudo rm -rf /opt/sshc_v5/'
	echo '	sudo rm -f /usr/bin/sshc'
}


# check dependencies on system
function check_f {
	echo "[+] check dependencies on system:  "
	for program in whoami sleep cat head tail cut expr curl nano openssl sshpass
	do
		if [ ! -z `which $program 2> /dev/null` ] ; then
			echo -e "[+] $program found"
		else
			echo -e "[-] Error: $program not found"
		fi
		sleep 0.5
	done
}


case $1 in
	-i) install_f ;;
	-c) check_f ;;
	-u) uninstall_f ;;
	*) help_f ;;
esac
