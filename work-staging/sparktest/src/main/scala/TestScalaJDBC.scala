import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import scala.collection._
import org.apache.spark.sql._
import org.apache.spark.sql.types._
import org.apache.log4j.Logger
import org.apache.log4j.Level
import com.jaguar.jdbc.internal.jaguar._
import com.jaguar.jdbc.JaguarDataSource
import org.apache.hadoop.io._
import org.apache.hadoop.util._;
import scala.util.Random;
import scala.io.Source

import java.sql.{Connection, DriverManager, ResultSet}

object TestScalaJDBC {

	// ctor section
	private val _rand = new scala.util.Random;
	val _pt: Array[String] = new Array(12); 
	val _pt2: Array[String] = new Array(12); 
	_pt(0) = "50元星礼卡"
	_pt(1) = "80元星礼卡"
	_pt(2) = "100元星礼卡"
	_pt(3) = "200元星礼卡"
	_pt(4) = "300元星礼卡"
	_pt(5) = "500元星礼卡"
	_pt(6) = "美式咖啡"
	_pt(7) = "拿铁"
	_pt(8) = "抹茶拿铁"
	_pt(9) = "焦糖玛奇朵"
	_pt(10) = "当季特饮"
	_pt(11) = "当季特饮-2"
	_pt2(0) = "svc"
	_pt2(1) = "svc"
	_pt2(2) = "svc"
	_pt2(3) = "svc"
	_pt2(4) = "svc"
	_pt2(5) = "svc"
	_pt2(6) = "coupon"
	_pt2(7) = "coupon"
	_pt2(8) = "coupon"
	_pt2(9) = "coupon"
	_pt2(10) = "coupon"
	_pt2(11) = "coupon"
    val _ptlen = 12;

    def main(args: Array[String]) {
		sparkInsert( args(0), args(1), args(2) )
		/**
		sparkInsert( args(0), args(1), args(2) )
		sparkfunc()
		sparkfunc2()
		**/

		// insert_raw_cache(  args(0), args(1), args(2) )
    }

	def sparkfunc()
	{
        Class.forName("com.jaguar.jdbc.JaguarDriver");
        val sparkConf = new SparkConf().setAppName("TestScalaJDBC")
        val sc = new SparkContext(sparkConf)
        val sqlContext = new org.apache.spark.sql.SQLContext(sc)
		import sqlContext.implicits._

		val hadoopConf = new org.apache.hadoop.conf.Configuration()
		val hdfs = org.apache.hadoop.fs.FileSystem.get(new java.net.URI("hdfs://localhost:9000"), hadoopConf)

		// Logger.getLogger("org").setLevel(Level.OFF)
		// Logger.getLogger("akka").setLevel(Level.OFF)

		val url = "jdbc:jaguar://127.0.0.1:8900/test";

		val people = sqlContext.read.format("jdbc")
		   .options(
		       Map( "url" -> url,
			        "dbtable" -> "int10k",
					"user" -> "admin",
					"password" -> "jaguar",
					"partitionColumn" -> "k1",
					"lowerBound" -> "2",
					"upperBound" -> "2000000",
					"numPartitions" -> "4",
					"driver" -> "com.jaguar.jdbc.JaguarDriver"
		   )).load()
		    
		// work fine
		people.registerTempTable("int10k")
		people.printSchema()

		val people2 = sqlContext.read.format("jdbc")
		   .options(
		       Map( "url" -> url,
			        "dbtable" -> "int10k_2",
					"user" -> "admin",
					"password" -> "jaguar",
					"partitionColumn" -> "k1",
					"lowerBound" -> "2",
					"upperBound" -> "2000000",
					"numPartitions" -> "4",
					"driver" -> "com.jaguar.jdbc.JaguarDriver"
		   )).load()
		people2.registerTempTable("int10k_2")
		people2.printSchema();

		// works fine
		if ( false )  {
			val output = "/tmp/sparkout.txt";
			try { hdfs.delete(new org.apache.hadoop.fs.Path(output), true) } 
			catch { case _ : Throwable => { } }

			people.sort("k2").show()
			people.sort($"k2".desc).show()
			people.sort($"k2".desc, $"k1".asc).show()
			people.orderBy($"k2".desc, $"k1".asc).show()
			// people.rdd.coalesce(1).saveAsTextFile("/tmp/sparkout.txt");
			// people.coalesce(1).rdd.saveAsTextFile("/tmp/sparkout.txt");
			people.toJSON.coalesce(1).saveAsTextFile( output );
		}

		// works fine
		// people.selectExpr("k2", "k1"  ).show()
		// people.selectExpr("k2", "k1 as keyone"  ).show()
		// people.selectExpr("k2", "k1 as keyone", "abs(k2)" ).show()

		val conn= DriverManager.getConnection(url, "admin", "jaguar" );
		val st2 = conn.createStatement()
		st2.executeUpdate( "drop table if exists jbench ;");
		st2.executeUpdate( "create table jbench (key: uid char(16), value: addr char(32) );");
		var i = 0;
		while ( i < 120000 ) {
			val sql = "insert into jbench values (spark" + i + ", spark" + i + ");"
			st2.executeUpdate( sql );
			 i = i + 1;
		}

		conn.commit();
		// conn.close();
		// return;

		st2.executeUpdate( "insert into jbench values (qqq22, qqqqq222)")
		st2.executeUpdate( "insert into jbench values (qqq23, qqqqq222)")
		st2.executeUpdate( "update jbench set addr=999999 where uid=qqq22")
		st2.executeUpdate( "delete from jbench where uid=qqq23")


		// bad
		// people.insertInto( "int10k_2", false );
		// people.write().jdbc(url, "int10k_2", true );
		people.insertIntoJDBC(url, "int10k_2", true );


		// workd fine
        val k12 = people.select("k1", "k2")
		k12.show();

		// workd fine
        val sk1 = people.select("k1")
		sk1.show();

		// workd fine
        val sk2 = people.select("k2")
		sk2.show();
		
		// works fine
        val below60 = people.filter(people("k1") <= 3927570 ).show()

		// works fine
		people.groupBy("addr").count().show()

		// works fine
        people.groupBy("addr").avg().show()

		// bad
		/***
        people.groupBy(people("addr"))
		       .agg(
			   		Map(
						 "k2" -> "avg",
						 "k1" -> "max"
					   )
				   )
			   .show();
		   **/

		// bad
		/**
        people.rollup("addr").avg().show()
        people.rollup($"addr")
		       .agg(
			   		Map(
						 "k1" -> "avg",
						 "k2" -> "max"
					   )
				   )
			   .show();
		

        people.cube($"addr").avg().show()
        people.cube($"addr")
		       .agg(
			   		Map(
						 "k1" -> "avg",
						 "k2" -> "max"
					   )
				   )
			   .show();
		  **/

		// cannot compile
		// people.agg( max($"k1"), avg($"k2") ).show()
		// .agg is short for groupBy().agg()
		// people.groupBy().agg(max($"k2"), avg($"k1"))

		// works great
		people.describe( "k1", "k2").show()

		// works great 
		people.stat.freqItems( Seq("k1") ).show()

		// works great  
		people.join( people2, "k1" ).show()
		people.join( people2, "k2" ).show()

		// not compile people.join( people2, Seq("k2", "addr") ).show()
		// not compile people.join( people2, Seq("k1", "k2") ).show()
		// not compile people.join( people2).where ( $"people.k1" === $"people2.k1" ).show()

		// works fine
		people.join(people2).where ( people("k1") === people2("k1")  ).show()

		// works fine
		people.join(people2).where ( people("addr") === people2("addr")  ).show()
		
		// works fine
		people.join(people2).where ( people("k1") === people2("k1") and people("addr") === people2("addr")  ).show()
		people.join(people2).where ( people("k1") === people2("k1") && people("addr") === people2("addr") ).show()
		people.join(people2).where ( people("k1") === people2("k1") && people("addr") === people2("addr") )
			.limit(3).show()

		// works fine
		 people.unionAll(people2).show()
		 people.intersect(people2).show()
		 people.except(people2).show()
		 people.sample( true, 0.1, 100 ).show()
		 people.distinct.show()
		 people.dropDuplicates().show()
		 people.dropDuplicates.show()

		// works fine
		 people.dropDuplicates.cache.show()
		 people.dropDuplicates.persist.show()

		// not compile
		// val inf = people.inputFiles()

		// save fails with table must be temp table error
		// people.show()
		// bad people.write.mode(SaveMode.Append).saveAsTable("int10k_3")
		// bad people.write.saveAsTable("int10k_3")

		// bad val df = sqlContext.sql("SELECT * FROM int10k where k1 < 200000000 ")
		// OK val df = sqlContext.sql("SELECT k1, k2, addr FROM int10k where k1 < 200000000 ")
        // df.groupBy("addr").count.show()
		// bad val df = sqlContext.sql("SELECT k2, addr, k1 FROM int10k where k1 < 200000000 ")

		// works
		val df = sqlContext.sql("SELECT * FROM int10k where k1 < 200000000 and addr between 'JDHJDH' and 'ZBJDDJDJKDJKJDKJKD' ")
        df.distinct.show()
	}

	def sparkfunc2()
	{
        Class.forName("com.jaguar.jdbc.JaguarDriver");
        val sparkConf = new SparkConf().setAppName("TestScalaJDBC")
        val sc = new SparkContext(sparkConf)
        val sqlContext = new org.apache.spark.sql.SQLContext(sc)
		import sqlContext.implicits._

		val hadoopConf = new org.apache.hadoop.conf.Configuration()
		val hdfs = org.apache.hadoop.fs.FileSystem.get(new java.net.URI("hdfs://localhost:9000"), hadoopConf)

		Logger.getLogger("org").setLevel(Level.OFF)
		Logger.getLogger("akka").setLevel(Level.OFF)

        var url = "jdbc:jaguar://127.0.0.1:8900/test";
		val people = sqlContext.read.format("jdbc")
		   .options(
		       Map( "url" -> url,
			        "dbtable" -> "tm3",
					"user" -> "admin",
					"password" -> "jaguar",
					"partitionColumn" -> "uid",
					"lowerBound" -> "2",
					"upperBound" -> "2000000",
					"numPartitions" -> "4",
					"driver" -> "com.jaguar.jdbc.JaguarDriver"
		   )).load()
		    
		// work fine
		people.registerTempTable("tm3")
		people.printSchema()


		// works
		val df = sqlContext.sql("SELECT uid, sum(amt) as amt_sum FROM tm3 where daytime > '2014-01-01 00:00:00' and daytime < '2014-03-01 0:0:0' group by uid ")
        // df.distinct.show()
		df.rdd.map( row=> "uid: " + row(0) ).collect().foreach( println)
		df.foreach( println)

        df.show()
		val output = "/tmp/sparkout.txt";
		df.toJSON.coalesce(1).saveAsTextFile( output );
	}

	def randomString( len: Int ): String =  {
		val builder = StringBuilder.newBuilder
		var i = 0;
		while ( i < len ) {
			// str +=  _rand.nextPrintableCharacter();
			val c = _rand.nextPrintableChar()
			if  ( c != '\'' && c != '"' && c != '\\' && c != '`' ) {
				builder.append( c );
				i = i +1;
				// println( "c=[" + c + "]" );
			} else {
				// println( "got=["+c + "]" );
			}
		}
		// return builder.toString()
		// println( "sotstr=[" + builder.toString() + "]" );
		builder.toString()
	}

	def randomAlphaNumericString(length: Int): String = {
		val chars = ('a' to 'z') ++ ('A' to 'Z') ++ ('0' to '9')
		randomStringFromCharList(length, chars)
	}
  
	def randomStringFromCharList(length: Int, chars: Seq[Char]): String = {
		val sb = new StringBuilder
		for (i <- 1 to length) {
			val randomNum = util.Random.nextInt(chars.length)
			sb.append(chars(randomNum))
		}
		sb.toString
	}

	def sparkInsert( ip : String, port : String, len : String )
	{
        Class.forName("com.jaguar.jdbc.JaguarDriver");
        val sparkConf = new SparkConf().setAppName("TestScalaJDBC")
        val sc = new SparkContext(sparkConf)
        val sqlContext = new org.apache.spark.sql.SQLContext(sc)
		import sqlContext.implicits._

		val hadoopConf = new org.apache.hadoop.conf.Configuration()
		val hdfs = org.apache.hadoop.fs.FileSystem.get(new java.net.URI("hdfs://localhost:9000"), hadoopConf)

		// Logger.getLogger("org").setLevel(Level.OFF)
		// Logger.getLogger("akka").setLevel(Level.OFF)

		val url = "jdbc:jaguar://" + ip + ":" + port + "/test"
		val conn= DriverManager.getConnection(url, "admin", "jaguar" )
		val st2 = conn.createStatement()
		// st2.executeUpdate( "drop table if exists news_data;")
		// st2.executeUpdate( "create table news_data( key: companyCode char(60), guid char(50), value: dayOfNewsTime char(10), sentimentTag int, sourceNewsTime datetime, correlationTag char(60), industry char(90), companyName char(300), companyBriefName char(300), sourceUrl char(300), title char(600), digest char(300));")

		var i = 0;
		while ( i < len.toInt ) {
			val sql:String = makeInsert()
			// println( sql );
			st2.executeUpdate( sql );
			 i = i + 1;
		}

		conn.commit()
		conn.close()
	}

	def makeInsert() : String = {
		val prod_id = _rand.nextInt( 20 ) + 1
		val code_no = randomAlphaNumericString( 64 ) 
		val status = _rand.nextInt( 4 ) + 1
		val flog_time = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS")
		val log_time = flog_time.format(new java.util.Date())
		val uuid = _rand.nextInt( 9999999 )
				
		val card_id = randomAlphaNumericString( 28 )
		val prod_no = _rand.nextInt( 2000000000 )
        var iprod : Int = _rand.nextInt( _ptlen )
		val prod_name = _pt( iprod )
		val prod_type = _pt2( iprod )
		val price = _rand.nextInt( 500 ) + _rand.nextDouble()
		val log_time_ms = flog_time.parse( log_time ).getTime()
		val log_time_y = flog_time.parse( log_time ).getYear() + 1900
		val log_time_m = flog_time.parse( log_time ).getMonth() + 1
		val log_time_d = flog_time.parse( log_time ).getDate()
		var log_time_q = 1
		if ( log_time_m > 3 && log_time_m <= 6 ) {
			log_time_q = 2
		} else if ( log_time_m > 6 && log_time_m <= 9 ) {
			log_time_q = 3
		} else if ( log_time_m > 9 && log_time_m <= 12 ) {
			log_time_q = 4
		}
		val log_time_w = flog_time.parse( log_time ).getDay()
		val log_time_h = flog_time.parse( log_time ).getHours()
		val log_time_1 = flog_time.parse( log_time ).getMinutes()
		val log_time_5 = log_time_1/5*5
		val log_time_10 = log_time_1/10*10
		val log_time_30 = log_time_1/30*30

		// val q:String = "insert into starbucks.egift_item values ( '%d', '%s', '%d', '%s', '%s', '%s', '%s', '%s', '%s', '%f', '%s', '%s', '%ld', '%s', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%d', '%f', '%f', '%f', '%s', '%s', '%s', '%s', '%Lf', '%Lf', '%ld', '%ld', '%d', '%d', '%s', '%s' )".format( prod_id, code_no, status, log_time, uuid, card_id, prod_no, prod_name, prod_type, price, code_check_no, card_cover, log_time_ms, log_time_ymd, log_time_y, log_time_q, log_time_m, log_time_d, log_time_w, log_time_h, log_time_1, log_time_5, log_time_10, log_time_30, order_id, order_no, merchant_id, merchant_type, pos_id, consume_serial_no, store_name, swap_type, from_user, to_user, accept_type, use_amt, refund_amt, balance_amt, ext_char1, ext_char2, ext_char3, ext_char4, ext_double1, ext_double2, ext_bigint1, ext_bigint2, ext_int1, ext_int2, ext_time1, ext_time2)
		val q:String = "insert into starbucks.egift_item values ( '%d', '%s', '%d', '%s', '%d', '%s', '%d', '%s', '%s', '%f', '', '', '%d', '%d%02d%02d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '' )".format( prod_id, code_no, status, log_time, uuid, card_id, prod_no, prod_name, prod_type, price, log_time_ms, log_time_y, log_time_m, log_time_d, log_time_y, log_time_q, log_time_m, log_time_d, log_time_w, log_time_h, log_time_1, log_time_5, log_time_10, log_time_30 )
		q
	}

	def makeInsertShort() : String = {
        var prod_id : Int = _rand.nextInt( _ptlen )
        var card_id : String = randomString(50)

        // val prod_name = randomString(150);
        val prod_name = randomString(50);

        val prod_type = _pt(prod_id);
        val code_no =  randomString(50);

        // val code_check_no = randomString(50);
        val code_check_no = randomString(40);
		
        val status = 1+_rand.nextInt(4);

        // val card_cover = randomString(50);
        val card_cover = randomString(40);

		val formatLog = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
		val log_time = formatLog.format(new java.util.Date())

        val log_time_ms = java.lang.System.currentTimeMillis();
        val log_time_ymd = "20171210";
        val log_time_y = "2017";
		
        // val uuid =  randomString(700);
        val uuid =  randomString(70);

        // val msg =  randomString(50);
        val msg =  randomString(20);

		val q:String = "insert into jgiftspark values ( '%d', '%s', '%s', '%s', '%s', '%s', '%d', '%s', '%s', '%s', '%s', '%s', '%s', '%s' )".format( 
          prod_id, card_id, prod_name, prod_type, code_no, code_check_no, status, card_cover, log_time, 
		  log_time_ms, log_time_ymd, log_time_y, uuid, msg);
		q
	}

	def insert_raw_cache( ip : String, port : String, fpath : String )
	{
        Class.forName("com.jaguar.jdbc.JaguarDriver");
        val sparkConf = new SparkConf().setAppName("TestScalaJDBC")
        val sc = new SparkContext(sparkConf)
        val sqlContext = new org.apache.spark.sql.SQLContext(sc)
		import sqlContext.implicits._

		val url = "jdbc:jaguar://" + ip + ":" + port + "/test"
		val conn= DriverManager.getConnection(url, "admin", "jaguar" )
		val st2 = conn.createStatement()

		var i = 0;
		for ( line <- Source.fromFile( fpath).getLines() ) {
			val arr = line.split('|')
			if ( arr.length >= 75 ) {
				val sql = "insert into raw_cache values ( '" + arr(30) + "', '" + arr(0) + "', '" + arr(2) + "', '" + arr(4) + "', '" + arr(6) + "', '" + arr(8) + "', '" + arr(10) + "', '" + arr(12) + "', '" + arr(14) + "', '" + arr(16) + "', '" + arr(18) + "', '" + arr(20) + "', '" + arr(22) + "', '" + arr(24) + "', '" + arr(26) + "', '" + arr(28) + "', '" + arr(32) + "', '" + arr(34) + "', '" + arr(36) + "', '" + arr(38) + "', '" + arr(40) + "', '" + arr(42) + "', '" + arr(44) + "', '" + arr(46) + "', '" + arr(48) + "', '" + arr(50) + "', '" + arr(52) + "', '" + arr(54) + "', '" + arr(56) + "', '" + arr(58) + "', '" + arr(60) + "', '" + arr(62) + "', '" + arr(64) + "', '" + arr(66) + "', '" + arr(68) + "', '" + arr(70) + "', '" + arr(72) + "', '" + arr(74) + "' ) '"
				st2.executeUpdate( sql );
				 i = i + 1;
			}
		}

		conn.commit()
		conn.close()
		println( "Inserted " + i + " lines" )
	}

}

