#! /bin/bash
# Programming and idea by : E2MA3N [Iman Homayouni]
# Email : e2ma3n@Gmail.com
# Website : http://OSLearn.ir
# License : GPL v3.0
# sshc v2.0 - installer [SSH Management Console]
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

if [ ! -d /etc/sshc/ ] ; then
	mkdir /etc/sshc
fi

if [ -f /etc/sshc/sshc.database ] ; then
	echo -e "[-] Error: /etc/sshc/sshc.database exist"
	exit 1
fi
}

# install program clearly
function install {
check1
check2
cp sshc /usr/bin/sshc
cp sshc.database /etc/sshc
chown root:root /etc/sshc/sshc.database
chmod 700 /etc/sshc/sshc.database
echo -e "[!] Warning: Edit /etc/sshc/sshc.database and put your server informations."
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

if [ ! -f /etc/sshc/sshc.database ] ; then
	echo -e "[-] Error: /etc/sshc/sshc.database not found"
else
	rm -f /etc/sshc/sshc.database
fi

if [ ! -d /etc/sshc/ ] ; then
	echo -e "[-] Error: /etc/sshc/ not found"
else
	rm -rf /etc/sshc/
fi
echo -e "[+] Done"
}

# help function
function usage {
echo "Usage: "
echo "	sudo ./install.sh -i [for install program]"
echo "	sudo ./install.sh -u [for uninstall program]"
}

case $1 in
	-i) install ;;
	-u) uninstall ;;
	*) usage ;;
esac