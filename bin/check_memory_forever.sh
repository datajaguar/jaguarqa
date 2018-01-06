# Script Name: check_memory_forever.sh
# Purpose: A utility to monitor the resouces in the distributed system.
# Command Line: nohup check_memory_forever.sh > check_memory_forever.sh.out &
# Note: a few system end needs to be set up.
 
jaguarstatus_on_all_hosts.sh
while true
do
    echo -e "\n# Time is row: `date +%Y_%m_%d_%H:%M:%S`"
    echo -e  "#######################################\n"
    
    echo -e "Run \"jaguarstatus_on_all_hosts.sh\":"
    echo -e "#####################################\n"
    jaguarstatus_on_all_hosts.sh
   
    echo -e  "#######################################\n"
    sshall "free -h" 
    sleep 30
done
