#!/bin/bash
exec > /dev/null 2>&1

clear  > /dev/tty 2>&1
echo -e "\n" > /dev/tty 2>&1

echo " ██████╗  █████╗ ████████╗ █████╗ ███████╗████████╗ █████╗ ██╗  ██╗ "  > /dev/tty 2>&1
echo " ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔════╝╚══██╔══╝██╔══██╗╚██╗██╔╝ "  > /dev/tty 2>&1
echo " ██║  ██║███████║   ██║   ███████║███████╗   ██║   ███████║ ╚███╔╝  "  > /dev/tty 2>&1
echo " ██║  ██║██╔══██║   ██║   ██╔══██║╚════██║   ██║   ██╔══██║ ██╔██╗  "  > /dev/tty 2>&1
echo " ██████╔╝██║  ██║   ██║   ██║  ██║███████║   ██║   ██║  ██║██╔╝ ██╗ "  > /dev/tty 2>&1
echo " ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ "  > /dev/tty 2>&1
echo "                                                                    "  > /dev/tty 2>&1
echo "  █████╗  ██████╗ █████╗ ██████╗ ███████╗███╗   ███╗██╗   ██╗    "  > /dev/tty 2>&1   
echo " ██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝████╗ ████║╚██╗ ██╔╝    "  > /dev/tty 2>&1  
echo " ███████║██║     ███████║██║  ██║█████╗  ██╔████╔██║ ╚████╔╝     "  > /dev/tty 2>&1  
echo " ██╔══██║██║     ██╔══██║██║  ██║██╔══╝  ██║╚██╔╝██║  ╚██╔╝      "  > /dev/tty 2>&1  
echo " ██║  ██║╚██████╗██║  ██║██████╔╝███████╗██║ ╚═╝ ██║   ██║       "  > /dev/tty 2>&1 
echo " ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝     ╚═╝   ╚═╝       "  > /dev/tty 2>&1  

echo -ne "\n\n Configuring the lab envronment " > /dev/tty 2>&1

until [[ -e /usr/lib/jvm && -e /usr/bin/java ]]
do
     sleep 1
     echo -n '.' > /dev/tty 2>&1
done

cd cassandra/bin
./cassandra > /dev/null 2>&1 &

echo -e "\n\n" > /dev/tty 2>&1
echo -e " Lab environment ready!\n\n" > /dev/tty 2>&1
echo -e " Click \033[1mSTART\033[0m to continue." > /dev/tty 2>&1
echo -e "\n" > /dev/tty 2>&1

PS1="\w $ "

exec > /dev/tty 2>&1