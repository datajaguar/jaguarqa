#

# Script Name: stop_all_cassandra_concurrent.sh

hs=`./gethosts.sh`
# gethosts.sh contains ip address for the 5 data nodes.

for h in $hs
do
	ssh $h "~/software/datastax-ddc-3.9.0/bin/cassandra" &
done

