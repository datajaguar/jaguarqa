import com.jaguar.jdbc.internal.jaguar.Jaguar;
import java.io.*;

public class example
{
    public static void main(String[] args)
    {
        System.loadLibrary("JaguarClient");  // need -Djava.library.path in Linux
        Jaguar client = new Jaguar();
        boolean rc = client.connect( args[0], Integer.parseInt( args[1] ), "admin", "jaguar", "test", "dummy", 0 );
		if ( ! rc ) {
           	System.out.println( "Connection error");
			System.exit(1);
		}
		
        rc = client.query( "select uid, addr from jbench limit 10;" );
        String val;
        while ( client.reply() ) {
            val = client.getValue(  "uid" );
            System.out.println( "uid=" + val );

            val = client.getNthValue( 1 );
            System.out.println( "col1="+val );

            val = client.getValue( "v1" );
            System.out.println( "v1="+val );
            val = client.getNthValue( 2 );
            System.out.println( "col2="+val );

            val = client.getValue( "v2" );
            System.out.println( "v2="+val );
            val = client.getNthValue( 3 );
            System.out.println( "col3="+val );

            val = client.getNthValue( 5 );
            System.out.println( "col5=" + val );

            val = client.getNthValue( 0 );
            System.out.println( "col0=" + val );

            val = client.getNthValue( -1 );
            System.out.println( "col -1=" + val );

            val = client.jsonString();
            System.out.println( "json=" + val );

        }

        if ( client.hasError( ) ) {
             String e = client.error( );
             System.out.println( e );
        }

        client.close();
    }
 }


