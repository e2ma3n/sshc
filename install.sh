#! /bin/bash
# Programming and idea by : E2MA3N [Iman Homayouni]
# Gitbub : https://github.com/e2ma3n
# Email : e2ma3n@Gmail.com
# Website : http://www.homayouni.info
# License : GPL v2.0
# Last update : 29-December-2019_14:21:57
# sshc v7.0 - installer [SSH Management Console]
#--------------------------------------------------------#

# check root privilege
[ "$UID" != "0" ] && echo -e '[-] Please use root user or sudo' && exit 1


# help function
function help_f {
	echo "Usage: "
	echo "	sudo ./install.sh -i [install program]"
	echo '	sudo ./install.sh -u [help to uninstall program]'
	echo "	sudo ./install.sh -c [check dependencies]"
	echo "	sudo ./install.sh --update [update program for just sshc.sh]"
}


# install program on system
function install_f {
	[ ! -d /opt/sshc/ ] && mkdir -p /opt/sshc/ && echo "[+] Directory created" || echo "[-] Error: /opt/sshc/ exist"
	sleep 1
	[ ! -f /opt/sshc/sshc.sh ] && cp sshc.sh /opt/sshc/ && chmod 755 /opt/sshc/sshc.sh && echo "[+] sshc.sh copied" || echo "[-] Error: /opt/sshc/sshc.sh exist"
	sleep 1
	[ ! -f /opt/sshc/sshc.database.en ] && cp sshc.database.en /opt/sshc/sshc.database.en && chown root:root /opt/sshc/sshc.database.en && chmod 700 /opt/sshc/sshc.database.en && echo "[+] sshc.database.en copied" || echo "[-] Error: /opt/sshc/sshc.database.en exist"
	sleep 1
	[ -f /opt/sshc/sshc.sh ] && ln -s /opt/sshc/sshc.sh /usr/bin/sshc && echo "[+] symbolic link created" || echo "[-] Error: symbolic link not created"
	sleep 1
	[ ! -f /opt/sshc/README.md ] && cp README.md /opt/sshc/README.md && chmod 644 /opt/sshc/README.md && echo "[+] README.md copied" || echo "[-] Error: /opt/sshc/README.md exist"
	sleep 1

	echo "[+] Please see README.md"
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
	echo '	sudo rm -rf /opt/sshc/'
	echo '	sudo rm -f /usr/bin/sshc'
}


# update program
function update_f {
	cp sshc.sh /opt/sshc/sshc.sh
	[ "$?" = "0" ] && echo "[+] sshc.sh updated"
}


# check dependencies on system
function check_f {
	echo "[+] check dependencies on system:  "
	for program in whoami sleep cat head tail cut expr curl nano openssl sshpass cp grep
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
	--update) update_f ;;
	*) help_f ;;
esac
