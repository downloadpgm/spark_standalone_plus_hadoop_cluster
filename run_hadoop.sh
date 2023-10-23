trap "{ echo Stopping play app; /root/stop_hadoop.sh; exit 0; }" SIGTERM

export JAVA_HOME=/usr/local/jre1.8.0_181
export CLASSPATH=$JAVA_HOME/lib
export PATH=$PATH:.:$JAVA_HOME/bin

export HADOOP_HOME=/usr/local/hadoop-2.7.3
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

service ssh start

echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
ssh-keyscan ${HOSTNAME} >~/.ssh/known_hosts

# run block if hadoop master
if [ -z "${HADOOP_MASTER}" ]; then

   # create the hadoop conf files
   create_conf_files_hadoop.sh

   # force slaves file to be emptied
   [ "${HADOOP_MULTINODE}" == "yes" ] && >${HADOOP_CONF_DIR}/slaves

   # if a new hadoop cluster, build a HDFS
   # if restarted from previous hadoop cluster run, preserve HDFS
   if [ ! -f /hadoop/hdfs/namenode/current/VERSION ]; then
     $HADOOP_HOME/bin/hdfs namenode -format
   fi

   # start HDFS and YARN services
   $HADOOP_HOME/sbin/start-dfs.sh
   # $HADOOP_HOME/sbin/start-yarn.sh
   
   sleep 5 
   
   echo "OK" >/root/masterOK
   
fi

# run block if hadoop node or in case node being added to cluster
if [ -n "${HADOOP_MASTER}" ]; then

   # monitor until hadoop master is available
   result=1
   while [ ${result} -ne 0 ]; do
      ssh -q root@${HADOOP_MASTER} "echo 2>&1 >/dev/null"
      result=$(echo $?)
      sleep 2
   done
   
   # monitor if hadoop master started named and resourced daemons
   result=1
   while [ ${result} -ne 0 ]; do
      ssh -q root@${HADOOP_MASTER} "cat masterOK" >/dev/null
      result=$(echo $?)
	  sleep 2
   done
   
   # if OK, proceed with hadoop slaves setup

   # copy Hadoop config files from master
   scp root@${HADOOP_MASTER}:${HADOOP_CONF_DIR}/core-site.xml ${HADOOP_CONF_DIR}
   scp root@${HADOOP_MASTER}:${HADOOP_CONF_DIR}/hdfs-site.xml ${HADOOP_CONF_DIR}
   scp root@${HADOOP_MASTER}:${HADOOP_CONF_DIR}/mapred-site.xml ${HADOOP_CONF_DIR}
   scp root@${HADOOP_MASTER}:${HADOOP_CONF_DIR}/yarn-site.xml ${HADOOP_CONF_DIR}
   scp root@${HADOOP_MASTER}:${HADOOP_CONF_DIR}/hadoop-env.sh ${HADOOP_CONF_DIR}

   # start HDFS and YARN services
   $HADOOP_HOME/sbin/hadoop-daemon.sh start datanode
   # $HADOOP_HOME/sbin/yarn-daemon.sh start nodemanager
   
   ssh root@${HADOOP_MASTER} "echo ${HOSTNAME} >>${HADOOP_CONF_DIR}/slaves"

fi

while [ true ]; do 
   sleep 15
done
