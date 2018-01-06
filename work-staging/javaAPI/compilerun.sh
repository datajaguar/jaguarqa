# set the environment JAGUAR_HOME
JAGUAR_HOME=$HOME/jaguar-client
LIBPATH=$JAGUAR_HOME/lib
export LD_LIBRARY_PATH=$LIBPATH
#input path
filePath='/home/jaguar01/lpl/diffImg'
#compiler the program with javac
javac -cp $LIBPATH/jaguar-jdbc-2.0.jar:.  testJaguar.java
#run the program 
java -Djava.library.path=$LIBPATH -cp $LIBPATH/jaguar-jdbc-2.0.jar:. testJaguar $filePath 20.10.11.198 8111 jagwei test@1234567 test
