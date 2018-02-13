
val scalaCompiler = "org.scala-lang" % "scala-compiler" % "2.10.4"

lazy val root = (project in file(".")).
  settings(
    name := "TestScalaJDBC",
    version := "1.0",
    scalaVersion := "2.10.4"
)

libraryDependencies ++= Seq(
    "org.apache.spark" %% "spark-sql" % "1.4.1",
	"org.apache.spark" %% "spark-core" % "1.4.1"
)



