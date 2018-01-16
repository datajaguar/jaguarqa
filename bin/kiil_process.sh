# Utility to kill proces in batch
# command line: "kiil_process.sh performance_timer_main.sh"

ps -fu $LOGNAME |grep $1 > scilab_processID

cat scilab_processID  |
    while read line
    do
        set $line
        echo $2
                                                      #   sleep 1
        kill -9 $2
   done
