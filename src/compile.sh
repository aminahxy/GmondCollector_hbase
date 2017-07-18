#! /bin/sh
pwd=$(cd $(dirname $0);pwd)
ROOTPATH="${pwd}/.."
CLASSPATH=${ROOTPATH}/src
conf="${ROOTPATH}/conf"
JAVAPATH=/usr/local/jdk1.7.0_67
export JAVA_HOME=/usr/local/jdk1.7.0_67/
export JRE_HOME=/usr/local/jdk1.7.0_67/jre 
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$HADOOP_HOME/bin:$HIVE_HOME/bin:$PATH
echo $JAVA_HOME
java -version
# add libs to CLASSPATH
for f in ${ROOTPATH}/lib/*.jar; do
  CLASSPATH=${CLASSPATH}:$f;
done

for f in ${ROOTPATH}/lib/*/*.jar; do
  CLASSPATH=${CLASSPATH}:$f;
done

for f in $ROOTPATH}/lib/*/*/*.jar; do
  CLASSPATH=${CLASSPATH}:$f;
done

CLASSPATH="$conf:$CLASSPATH"
export CLASSPATH=$CLASSPATH
JAVA_HEAP_MAX="-Xmx1024m"
echo $CLASSPATH
${JAVAPATH}/bin/javac */*.java -cp ${CLASSPATH}
${JAVAPATH}/bin/javac */*/*.java -cp ${CLASSPATH}
${JAVAPATH}/bin/javac */*/*/*.java -cp ${CLASSPATH}
${JAVAPATH}/bin/javac */*/*/*/*.java -cp ${CLASSPATH}
${JAVAPATH}/bin/javac */*/*/*/*/*.java -cp ${CLASSPATH}
${JAVAPATH}/bin/javac */*/*/*/*/*/*.java -cp ${CLASSPATH}
${JAVAPATH}/bin/javac */*/*/*/*/*/*/*.java -cp ${CLASSPATH}
${JAVAPATH}/bin/jar cf GmondCollector-by.jar com/
#java -classpath $CLASSPATH $JAVA_HEAP_MAX com.sina.data.bigmonitor.cli.GmondCollectorManager $1
mv GmondCollector-by.jar ../lib
#${JAVAPATH}/bin/java -cp ./:./lib:./lib/*../lib/GmondCollector-by.jar:../lib/* com.sina.data.bigmonitor.cli.GmondCollectorManager $1  
