import jaguarpy, sys
jdb = jaguarpy.Jaguar()
rc = jdb.connect( "192.168.7.151", 8888, "admin", "jaguar", "test", "", 0)
jdb.query("select * from callinfo;");
while jdb.reply():
    a = jdb.getNthValue(2);
    ds = ' addr is ' + repr(a);
    print( ds );

