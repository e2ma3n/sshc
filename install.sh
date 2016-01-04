#! /bin/bash
# Programming and idea by : E2MA3N [Iman Homayouni]
# Email : e2ma3n@Gmail.com
# Website : http://OSLearn.ir
# License : GPL v3.0
# sshc v3.0 - installer [SSH Management Console]
#--------------------------------------------------------#

# check root privilege
function check1 {
if [ "`whoami`" != "root" ]; then
        echo -e '[-] Please use root user or sudo'
        exit 1
fi
}

# check config files for installation function
function check2 {
if [ -f /usr/bin/sshc ] ; then
	echo -e "[-] Error: /usr/bin/sshc exist"
	exit 1
fi

if [ -f /etc/sshc/sshc.database.en ] ; then
	echo -e "[-] Error: /etc/sshc/sshc.database.en exist"
	exit 1
else
	if [ ! -d /etc/sshc/ ] ; then
	mkdir /etc/sshc
	fi
fi
}

# install program clearly
function install {
check1
check2
cp sshc /usr/bin/sshc
cp sshc.database.en /etc/sshc/
chown root:root /etc/sshc/sshc.database.en
chmod 700 /etc/sshc/sshc.database.en
echo -e "[!] Warning: run program and edit your database."
echo -e "[!] Warning: defaul password is 'sshc'"
echo -e "[+] Done"
}

# uninstal program clearly
function uninstall {
check1
echo -en "[!] Warning: Do you want to continue ? (press enter to continue or ctrl+c for exit)" ; read

if [ ! -f /usr/bin/sshc ] ; then
	echo -e "[-] Error: /usr/bin/sshc not found"
else
	rm -f /usr/bin/sshc
fi

if [ ! -f /etc/sshc/sshc.database.en ] ; then
	echo -e "[-] Error: /etc/sshc/sshc.database.en not found"
else
	rm -f /etc/sshc/sshc.database.en
fi

if [ ! -d /etc/sshc/ ] ; then
	echo -e "[-] Error: /etc/sshc/ not found"
else
	rm -rf /etc/sshc/
fi
echo -e "[+] Done"
}

# check dependencies on system
function status {
	echo '[+] ------------------------------------------------ [+]'
	echo "[+] check dependencies on system:  "
	for program in openssl sshpass mkdir cp rm whoami ping curl ssh echo cat joe
	do
		if [ ! -z `which $program` ] ; then
			echo -e "[+] $program found"
		else
			echo -e "[-] Error: $program not found"
		fi
	done
	echo '[+] ------------------------------------------------ [+]'
}

# help function
function usage {
echo "Usage: "
echo "	sudo $0 -i [for install program]"
echo "	sudo $0 -u [for uninstall program]"
echo "	sudo $0 -c [check dependencies on system]"
}

case $1 in
	-i) install ;;
	-u) uninstall ;;
	-c) status ;;
	*) usage ;;
esac
