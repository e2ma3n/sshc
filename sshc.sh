#! /bin/bash
# Programming and idea by : E2MA3N [Iman Homayouni]
# Gitbub : https://github.com/e2ma3n
# Email : e2ma3n@Gmail.com
# Website : http://www.homayouni.info
# License : GPL v2.0
# Last update : 29-December-2019_14:21:57
# sshc v7.0 - core [SSH Management Console]
#--------------------------------------------------------#

# echo line
function line {
	echo '[+] ------------------------------------------------------------------- [+]'
}

# check root privilege
[ "$UID" != "0" ] && echo -e '[-] Please use root user or sudo' && exit 1


# data base location , Don not change this form
database_en="/opt/sshc/sshc.database.en"


# print header on terminal
reset
line
echo -e "[+] Programming and idea by : \e[1mE2MA3N [Iman Homayouni]\e[0m"
echo '[+] License : GPL v2.0'
echo -e '[+] sshc v7.0 \n'


# check encrypted database
[ ! -f $database_en ] && echo -e "[-] Error: $database_en not found" \
&& line \
&& exit 1


# decrypt database
echo -en "[+] Enter password: " ; read -s pass
database_de=$(openssl aes-256-cbc -md md5 -pass pass:$pass -d -a -in $database_en 2> /dev/null | tr -d '\000' 2> /dev/null)
echo "$database_de" | grep 'Dont change this form' &> /dev/null
[ "$?" != "0" ] && echo -e "\n[-] Error: Database can not decrypted." && line && exit 1 || echo


# print servers informations on terminal
echo -e "\n 0] Edit Database"
var0=$(echo "$database_de" | wc -l)
var0=$(expr $var0 - 12)
for (( i=1 ; i <= $var0 ; i++ )) ; do
	show_port=$(echo -en "$database_de" | tail -n $i | head -n 1 | cut -d " " -f 5)
	user_ip=$(echo -en "$database_de" | tail -n $i | head -n 1 | cut -d " " -f 1,3 | tr " " @)
	echo -ne " $i] " ; echo "$user_ip:$show_port"
done


# edite database
function edit_db {
	touch /opt/sshc/sshc.database.de
 	chown root:root /opt/sshc/sshc.database.de
 	chmod 600 /opt/sshc/sshc.database.de
	echo "$database_de" > /opt/sshc/sshc.database.de
	nano /opt/sshc/sshc.database.de
	echo -en "[+] encrypt new database, Please type your password: " ; read -s pass
	openssl aes-256-cbc -md md5 -pass pass:$pass -a -salt -in /opt/sshc/sshc.database.de -out $database_en 2> /dev/null
	rm -f /opt/sshc/sshc.database.de &> /dev/null
	echo -e "\n[+] Done, New database saved and encrypted"
	line
	exit 0
}


# select server for continue
while :; do
	echo -en '\e[0m\n[+] Select your server/option or type quit for exit: ' ; read var1

	if [ "$var1" = "0" ] ; then
		edit_db
	fi

	if [ "$var1" -le "$var0" ] 2> /dev/null ; then
		break
	elif [ "$var1" = "quit" ] ; then
		echo "[+] Done" ; line ; exit 1
	else
		echo "[-] Error: bad input" ; line ; exit 1
	fi
done


# read variables from database
username=$(echo "$database_de" | tail -n $var1 | head -n 1 | cut -d " " -f 1)
local_proxy_port=$(echo "$database_de" | tail -n $var1 | head -n 1 | cut -d " " -f 2)
ip_address=$(echo "$database_de" | tail -n $var1 | head -n 1 | cut -d " " -f 3)
remote_proxy_port=$(echo "$database_de" | tail -n $var1 | head -n 1 | cut -d " " -f 4)
ssh_port=$(echo "$database_de" | tail -n $var1 | head -n 1 | cut -d " " -f 5)
password=$(echo "$database_de" | tail -n $var1 | head -n 1 | cut -d " " -f 6)


# connect to server - tunnel mode
function function_0 {
	echo -e "[+] \e[93mLocal Tunnel IP: 127.0.0.1 \e[0m"
	echo -e "[+] \e[93mLocal Tunnel Port: $local_proxy_port \e[0m"
	line
	sshpass -p "$password" ssh -o StrictHostKeyChecking=no -l $username \
	-L $local_proxy_port\:127.0.0.1:$remote_proxy_port $ip_address -p $ssh_port
}

# connect to server - normal mode
function function_1 {
	line
	sshpass -p "$password" ssh -o StrictHostKeyChecking=no -l $username $ip_address -p $ssh_port
}


# add your ip address to firewall
function function_2 {
	if [ "$(echo "$database_de" | tail -n $var1 | head -n 1 | cut -d " " -f 1)" != "root" ] ; then
		echo "[-] Error: Your user is not root, we can not add your ip to firewall"
		line
		exit 1
	fi
	
	for (( i=1 ; i < 4 ; i++ )) ; do
		public_ip=$(curl ipecho.net/plain 2> /dev/null)
		[ ! -z "$public_ip" ] && break
	done
	
	echo -en "[+] $public_ip your public IP Address ? [y/n]: " ; read var3
	if [ "$var3" = "y" ] ; then
		sshpass -p "$password" ssh -o StrictHostKeyChecking=no -l $username $ip_address \
		-p $ssh_port "iptables -I INPUT -s $public_ip -j ACCEPT" &> /dev/null
		[ "$?" != "0" ] && echo "[-] Error: Can not connect to server." \
		line
		exit 1

	elif [ "$var3" = "n" ] ; then
		echo '[-] Are you shore ? Please try again'
		line
		exit 1

	else
		echo "[-] Error: Bad input"
		line
		exit 1
	fi
}


# status, checking up or down 
ping -c 1 $(echo "$database_de" | tail -n $var1 | head -n 1 | cut -d " " -f 3) &> /dev/null
if [ "$?" = "0" ] ; then
	echo -ne "\n You selected: \e[92m" ; echo "$database_de" | tail -n $var1 | head -n 1 | cut -d " " -f 3 
else
	echo -ne "\n You selected: \e[91m" ; echo "$database_de" | tail -n $var1 | head -n 1 | cut -d " " -f 3
fi

echo
if [ "$(echo "$database_de" | tail -n $var1 | head -n 1 | cut -d " " -f 1)" != "root" ] ; then
	echo -e "\e[0m 0] Connect to server (Tunnel mode)"
	echo -e " 1] Connect to server (Normal mode)"
else
	echo -e "\e[0m 0] Connect to server [Tunnel mode]"
	echo -e " 1] Connect to server [Normal mode]"
	echo -e " 2] Open your public IP address in server [Firewall]"
	echo -e " 3] \e[7moption 0 and option 2\e[0m"
	echo -e " 4] \e[7moption 1 and option 2\e[0m"
fi

echo -en "\n[+] Select your option or type quit for exit: " ; read q

case $q in
	0) function_0
		exit 0 ;;

	1) function_1
		exit 0 ;;

	2) function_2 
		echo "[+] Done"
		line ;;

	3) function_2
		echo "[+] Done"
		function_0 ;;

	4) function_2
		echo "[+] Done"
		function_1 ;;		
	
	quit) echo "[+] Done"
			line
			exit 0 ;;
	
	*) echo "[-] Error: Bad input"
		line
		exit 1 ;;
esac
