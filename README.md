# sshc - Managing and connecting to ssh without password 
## Introduction
when number of accesses to ssh gets high, managment gets hard, so in this time you can use this program for managing servers. By using this program you can select your server from menu and connect to server without password or add public ip address to server's firewall (iptables).

The project page is located at https://github.com/e2ma3n/sshc

## What distributions are supported ?
All popular linux distributions such as debian and CentOS

| Distribution | Version |
| ---------- | ----------- |
| Debian     | debian-9.1.0-amd64-netinst |
| Debian     | debian-8.9.0-amd64-netinst |
| Debian     | debian-7.11.0-amd64-netinst |
| CentOS     | centos-6.6-amd64 |
| CentOS     | centos-7-amd64 |
| LMDE       | lmde2 mate desktop - 3.16.0-4-amd64 |
| Chromixium | chromixium 1.5 - 3.13.0-66-generic |


## Dependencies

| Dependency | Description |
| ---------- | ----------- |
| whoami     | Print the user name associated with the current effective user ID.  Same as id -un. |
| grep       | grep searches the named input FILEs (or standard input if no files are named, or if a single hyphen-minus (-) is given as file name) for lines containing a match to the given PATTERN.  By default, grep prints the matching lines. |
| cut        | Print selected parts of lines from each FILE to standard output. |
| cat        | Concatenate FILE(s), or standard input, to standard output. |
| head       | Print the first 10 lines of each FILE to standard output. |
| tail       | Print the last 10 lines of each FILE to standard output. |
| cp         | Copy SOURCE to DEST, or multiple SOURCE(s) to DIRECTORY. |
| sleep      | Pause for NUMBER seconds. |
| curl       | curl is a tool to transfer data from or to a server. |
| expr       | evaluate expressions |
| nano       | nano is a small, free and friendly editor which aims to replace Pico, the default editor included in the non-free Pine package |
| openssl    | OpenSSL is a cryptography toolkit implementing the Secure Sockets Layer (SSL v2/v3) and Transport Layer Security (TLS v1) network protocols and related cryptography standards required by them. |
| sshpass    | sshpass is a utility designed for running ssh using the mode referred to as "keyboard-inter‐active" password authentication, but in non-interactive mode. |

## How to get source code ?
You can download and view source code from github : https://github.com/e2ma3n/sshc

Also to get the latest source code, run following command:
```
# git clone https://github.com/e2ma3n/sshc.git
```
This will create sshc directory in your current directory and source files are stored there.

## How to check dependencies on system ?
In the first step, set execute permission for install.sh :
```
# cd sshc
# chmod +x install.sh
```
Then, check dependencies, using -c switch :
```
# ./install -c
```

## How to install dependencies on debian ?
By using apt-get command; for example :
```
# apt-get install sshpass
# apt-get install curl
...
```

## How to install sshc ?
By using -i switch :
```
# ./install.sh -i
```

## How to uninstall ?
```
# rm -rf /opt/sshc_v6/
# rm -f /usr/bin/sshc
```


## Notes :
	1. run this program just using root user or sudo
	2. defaul password is 'sshc'
	3. run program and edit your database
	4. Special thanks to Mickael Dorigny from www.it-connect.fr for finding new bug

## License
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
