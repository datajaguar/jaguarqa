import jaguarpy, sys, os
jdb = jaguarpy.Jaguar()
rc = jdb.connect( "192.168.7.151", 8888, "admin", "jaguar", "test", "", 0)
jdb.query("select * from sys.argv[1];");
while jdb.reply():
    jdb.printRow();
    u = jdb.getValue("uid");
    a = jdb.getValue("addr");
    ds = 'uid is ' +repr(u) + ' addr is ' + repr(a);
    print( ds );

