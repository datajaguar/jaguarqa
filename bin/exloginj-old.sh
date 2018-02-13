host=127.0.0.1
host=192.168.7.151

export PATH=$PATH:~/jaguar/bin
export LD_LIBRARY_PATH=~/jaguar/lib

brand=`cat brand.txt`

port=`grep PORT ~/$brand/conf/server.conf |grep -v '#' | awk -F= '{print $2}'`

pass=admin
pass=jaguar
echo "rlwrap jag -u admin -p $pass -d test -h $host:$port $@"
echo "Port is $port"
rlwrap jag -u admin -p $pass -d test -h $host:$port -x yes $@
