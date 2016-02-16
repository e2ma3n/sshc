#! /bin/bash
# Programming and idea by : E2MA3N [Iman Homayouni]
# Gitbub : https://github.com/e2ma3n
# Email : e2ma3n@Gmail.com
# Website : http://OSLearn.ir
# License : GPL v3.0
# sshc v4.0 - installer [SSH Management Console]
#--------------------------------------------------------#

# check root privilege
[ "`whoami`" != "root" ] && echo -e '[-] Please use root user or sudo' && exit 1


# help function
function help_f {
	echo "Usage: "
	echo "	sudo ./install.sh -i [install program]"
	echo "	sudo ./install.sh -c [check dependencies]"
}


# install program on system
function install_f {
	[ ! -d /opt/sshc_v4/ ] && mkdir -p /opt/sshc_v4/ && echo "[+] Directory created" || echo "[-] Error: /opt/sshc_v4/ exist"
	sleep 1
	[ ! -f /opt/sshc_v4/sshc.sh ] && cp sshc.sh /opt/sshc_v4/ && chmod 755 /opt/sshc_v4/sshc.sh && echo "[+] sshc.sh copied" || echo "[-] Error: /opt/sshc_v4/sshc.sh exist"
	sleep 1
	[ ! -f /opt/sshc_v4/sshc.database.en ] && cp sshc.database.en /opt/sshc_v4/sshc.database.en && chown root:root /opt/sshc_v4/sshc.database.en && chmod 700 /opt/sshc_v4/sshc.database.en && echo "[+] sshc.database.en copied" || echo "[-] Error: /opt/sshc_v4/sshc.database.en exist"
	sleep 1
	[ -f /opt/sshc_v4/sshc.sh ] && ln -s /opt/sshc_v4/sshc.sh /usr/bin/sshc && echo "[+] symbolic link created" || echo "[-] Error: symbolic link not created"
	sleep 1
	[ ! -f /opt/sshc_v4/README ] && cp README /opt/sshc_v4/README && chmod 644 /opt/sshc_v4/README && echo "[+] README copied" || echo "[-] Error: /opt/sshc_v4/README exist"
	sleep 1

	echo "[+] Please see README"
	echo "[!] Warning: run program and edit your database."
	echo "[!] Warning: defaul password is 'sshc'"
	echo "[+] Done"
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
	done
}


case $1 in
	-i) install_f ;;
	-c) check_f ;;
	*) help_f ;;
esac
