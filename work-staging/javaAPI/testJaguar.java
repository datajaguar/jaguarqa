/*
* date: 2017-12-30 author: lpl 
*The purpose is to put the file into the dataDB.
*The number of input parameter is 5. 
*
*/
import com.jaguar.jdbc.JaguarDataSource;

import java.io.*;
import java.nio.channels.ClosedByInterruptException;
import java.sql.PreparedStatement;
import java.sql.DatabaseMetaData;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.sql.PseudoColumnUsage;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;

import com.jaguar.jdbc.JaguarResultSetMetaData;

import java.sql.ResultSetMetaData;

import com.jaguar.jdbc.JaguarDriver;

import java.sql.DriverManager;
import java.util.Properties;


/// Make sure in your enviroment the LD_LIBRARY_PATH point to the directory
// where libJaguarClient.so is located
// export LD_LIBRARY_PATH=$JAGUAR_HOME/jaguar/lib

public class testJaguar 
{	
	private JaguarDriver jagD ;
	private Properties prop ;
	private Connection connection; 
	private PreparedStatement ps;
	//private PreparedStatement preparedStatement;

	public static void main( String [] args ) throws SQLException, IOException {
		if (args.length!=5 && args.length!=6) {
			System.out.println("input error, Usage: filepath ip user pwd db");
			System.exit(1);
		}
		
		System.loadLibrary("JaguarClient");
	
		testJaguar t = new testJaguar();
		System.out.println( "Init database");
		t.Init(args[1],args[2],args[3],args[4],args[5]);
		System.out.println( "\n");
		System.out.println( "t.InsertDataToDB .........................................\n");
		File file=new File(args[0]);
		//if the input path is a file, then we put it into the dataDB.
		//or if not ,we list all files in the folder ,and then put file into dataDB.
		if (file.isFile()) {
			if(t.InsertDataToDB(file.getPath(), args[4]))
			{
				System.out.println("Insert sucessed!");
			}
			else {
				System.out.println("Insert failed!");
			}
		}
		else {
			//get all files in the folder 
			String [] files =file.list();
			System.out.println("the number of file is "+ files.length);
			for (int i=0;i<files.length;i++)
			{	
			
				if(t.InsertDataToDB(file.getPath()+"/"+files[i], args[4]))
				{	
					
					System.out.println("Insert file "+files[i]+" sucessed!");
				}
				else {
					System.out.println("Insert file "+files[i]+" failed!");
				}
			}
		}
		//close the connection.
		t.CloseDB();

	}
	
//Init the dataDB.
	public void Init(String ipString,String user,String pwd,String DB) throws SQLException
	{
		Init(ipString,"8888",user,pwd,DB);
	}
	
	public void Init(String ipString,String ports,String user,String pwd,String DB) throws SQLException
	{	
		 try {
	         	Class.forName("com.jaguar.jdbc.JaguarDriver");
	        } catch ( ClassNotFoundException e ) {
	            System.out.println( e.getMessage() );
	        }
		
			String url = "jdbc:jaguar://" + ipString + ":" + ports +"/"+DB;
			jagD = new JaguarDriver();
			
			prop = new Properties();
			prop.put("user", user );
			prop.put("password",pwd );
			prop.put("timeout", "34" );
			connection = jagD.connect( url, prop );
	}
//put the file which path is filepath  to the table which name is 'table'. 
public boolean InsertDataToDB(String filepath,String table)
{	
	try{
	//transform the file to stream by method 'readImage'
	FileInputStream in=readImage(filepath);
	
	String fileName = new File(filepath).getName();

	String sql="insert into "+"jbench"+"(uid,addr) values (?, ? ); ";
	
	ps=connection.prepareStatement(sql);

	ps.setString(1,fileName);
	System.out.println("insert size "+ in.available());

	ps.setBinaryStream(2,in,in.available());
	int count=ps.executeUpdate();
	
	if (count>0)
	{
		return true;
	}
	}catch(Exception e){e.printStackTrace();}
	return false;
}
	public static FileInputStream readImage(String path) throws IOException {
         return new FileInputStream(new File(path));
	}
	
	
	public void CloseDB() throws SQLException
	{
		ps.close();
		connection.close();
	}

}
