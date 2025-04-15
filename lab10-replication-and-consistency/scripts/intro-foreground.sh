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

#!/bin/bash

# List of directories to wait for
directories=(/home/cassandra-user/nodeA /home/cassandra-user/nodeB /home/cassandra-user/nodeC)

# Loop until all directories exist
while true; do
  all_exist=true
  for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
      all_exist=false
      break
    fi
  done

  if $all_exist; then
    break
  else
    sleep 1
    echo -n '.' > /dev/tty 2>&1
  fi
done

echo -e "\n\n" > /dev/tty 2>&1
echo -e " Lab environment ready!" > /dev/tty 2>&1
echo -e "\n" > /dev/tty 2>&1

exec > /dev/tty 2>&1

su - cassandra-user