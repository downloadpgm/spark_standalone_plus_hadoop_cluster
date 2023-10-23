# core-site.xml (HADOOP e SPARK)
# =============
echo '<configuration>' >$HADOOP_CONF_DIR/core-site.xml
echo '  <property>' >>$HADOOP_CONF_DIR/core-site.xml
echo '    <name>fs.default.name</name>' >>$HADOOP_CONF_DIR/core-site.xml
echo '    <value>hdfs://'${HOSTNAME}':9000</value>' >>$HADOOP_CONF_DIR/core-site.xml
echo '  </property>' >>$HADOOP_CONF_DIR/core-site.xml
echo '  <property>' >>$HADOOP_CONF_DIR/core-site.xml
echo '    <name>hadoop.tmp.dir</name>' >>$HADOOP_CONF_DIR/core-site.xml
echo '    <value>/hadoop/hdata</value>' >>$HADOOP_CONF_DIR/core-site.xml
echo '  </property>' >>$HADOOP_CONF_DIR/core-site.xml
echo '</configuration>' >>$HADOOP_CONF_DIR/core-site.xml

# hdfs-site.xml (HADOOP e SPARK)
# =============
echo '<configuration>' >$HADOOP_CONF_DIR/hdfs-site.xml
echo '  <property>' >>$HADOOP_CONF_DIR/hdfs-site.xml
echo '    <name>dfs.replication</name>' >>$HADOOP_CONF_DIR/hdfs-site.xml
echo '    <value>2</value>' >>$HADOOP_CONF_DIR/hdfs-site.xml
echo '  </property>' >>$HADOOP_CONF_DIR/hdfs-site.xml

echo '  <property>' >>$HADOOP_CONF_DIR/hdfs-site.xml
echo '    <name>dfs.name.dir</name>' >>$HADOOP_CONF_DIR/hdfs-site.xml
echo '    <value>/hadoop/hdfs/namenode</value>' >>$HADOOP_CONF_DIR/hdfs-site.xml
echo '  </property>' >>$HADOOP_CONF_DIR/hdfs-site.xml

echo '  <property>' >>$HADOOP_CONF_DIR/hdfs-site.xml
echo '    <name>dfs.data.dir</name>' >>$HADOOP_CONF_DIR/hdfs-site.xml
echo '    <value>/hadoop/hdfs/datanode</value>' >>$HADOOP_CONF_DIR/hdfs-site.xml
echo '  </property>' >>$HADOOP_CONF_DIR/hdfs-site.xml

echo '</configuration>' >>$HADOOP_CONF_DIR/hdfs-site.xml

# mapred-site.xml (HADOOP)
# ===============
echo '<configuration>' >$HADOOP_CONF_DIR/mapred-site.xml
echo '  <property>' >>$HADOOP_CONF_DIR/mapred-site.xml
echo '    <name>mapreduce.framework.name</name>' >>$HADOOP_CONF_DIR/mapred-site.xml
echo '    <value>yarn</value>' >>$HADOOP_CONF_DIR/mapred-site.xml
echo '  </property>' >>$HADOOP_CONF_DIR/mapred-site.xml
echo '</configuration>' >>$HADOOP_CONF_DIR/mapred-site.xml

# yarn-site.xml (HADOOP)
# =============
echo '<configuration>' >$HADOOP_CONF_DIR/yarn-site.xml

echo '  <property>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '    <name>yarn.nodemanager.aux-services</name>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '    <value>mapreduce_shuffle</value>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '  </property>' >>$HADOOP_CONF_DIR/yarn-site.xml

echo '  <property>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '    <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '    <value>org.apache.hadoop.mapred.ShuffleHandler</value>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '  </property>' >>$HADOOP_CONF_DIR/yarn-site.xml

echo '  <property>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '    <name>yarn.resourcemanager.resource-tracker.address</name>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '    <value>'${HOSTNAME}':8025</value>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '  </property>' >>$HADOOP_CONF_DIR/yarn-site.xml

echo '  <property>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '    <name>yarn.resourcemanager.scheduler.address</name>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '    <value>'${HOSTNAME}':8030</value>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '  </property>' >>$HADOOP_CONF_DIR/yarn-site.xml

echo '  <property>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '    <name>yarn.resourcemanager.address</name>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '    <value>'${HOSTNAME}':8040</value>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '  </property>' >>$HADOOP_CONF_DIR/yarn-site.xml

echo '    <property>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '      <name>yarn.scheduler.maximum-allocation-mb</name>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '      <value>2048</value>' >>$HADOOP_CONF_DIR/yarn-site.xml
echo '    </property>' >>$HADOOP_CONF_DIR/yarn-site.xml

echo '</configuration>' >>$HADOOP_CONF_DIR/yarn-site.xml


# hadoop-env.sh (HADOOP)
# =============
echo '' >>$HADOOP_CONF_DIR/hadoop-env.sh
echo 'export JAVA_HOME=/usr/local/jre1.8.0_181' >>$HADOOP_CONF_DIR/hadoop-env.sh
echo 'export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true' >>$HADOOP_CONF_DIR/hadoop-env.sh
echo 'export HADOOP_CONF_DIR='${HADOOP_HOME}'/etc/hadoop' >>$HADOOP_CONF_DIR/hadoop-env.sh
chmod +x $HADOOP_CONF_DIR/hadoop-env.sh
