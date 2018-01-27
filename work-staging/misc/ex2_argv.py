import jaguarpy, sys
jdb = jaguarpy.Jaguar()
rc = jdb.connect( "192.168.7.151", 8888, "admin", "jaguar", "test", "", 0)
table = sys.argv[1]
jdb.query("select * from $table;");
print table
while jdb.reply():
#    a = jdb.getNthValue(2);
    a = jdb.getValue("addr");
    ds = ' addr is ' + repr(a);
    print( ds );

