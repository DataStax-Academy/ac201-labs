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

echo -ne "\n\n Configuring the lab environment " > /dev/tty 2>&1

until /home/cassandra-user/cassandra/bin/cqlsh -e "DESCRIBE KEYSPACES;" > /dev/null 2>&1
do
     sleep 1
     echo -n '.' > /dev/tty 2>&1
done

echo -e "\n\n" > /dev/tty 2>&1
echo -e " Lab environment ready!" > /dev/tty 2>&1
echo -e "\n" > /dev/tty 2>&1

PS1="\w $ "

su cassandra-user -c "export PS1='\w $ '; /bin/bash --noprofile --norc" 2>&1

exec > /dev/tty 2>&1