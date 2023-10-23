FROM mkenjis/ubjava_img

#ARG DEBIAN_FRONTEND=noninteractive
#ENV TZ=US/Central

WORKDIR /usr/local

# wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
ADD hadoop-2.7.3.tar.gz .

WORKDIR /root
RUN echo "" >>.bashrc \
 && echo 'export HADOOP_HOME=/usr/local/hadoop-2.7.3' >>.bashrc \
 && echo 'export HADOOP_MAPRED_HOME=$HADOOP_HOME' >>.bashrc \
 && echo 'export HADOOP_COMMON_HOME=$HADOOP_HOME' >>.bashrc \
 && echo 'export HADOOP_HDFS_HOME=$HADOOP_HOME' >>.bashrc \
 && echo 'export YARN_HOME=$HADOOP_HOME' >>.bashrc \
 && echo 'export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop' >>.bashrc \
 && echo 'export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native' >>.bashrc \
 && echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' >>.bashrc

# authorized_keys already set in ubjava_img to enable containers connect to each other via passwordless ssh

# declare the Hadoop name and data directories to be exported
VOLUME /hadoop/hdfs/namenode
VOLUME /hadoop/hdfs/datanode

COPY create_conf_files_hadoop.sh .
COPY run_hadoop.sh .
COPY stop_hadoop.sh .

RUN chmod +x create_conf_files_hadoop.sh run_hadoop.sh stop_hadoop.sh

WORKDIR /usr/local

# wget https://archive.apache.org/dist/spark/spark-2.3.2/spark-2.3.2-bin-hadoop2.7.tgz
ADD spark-2.3.2-bin-hadoop2.7.tgz .

WORKDIR /root
RUN echo "" >>.bashrc \
 && echo 'export SPARK_HOME=/usr/local/spark-2.3.2-bin-hadoop2.7' >>.bashrc \
 && echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HADOOP_HOME/lib/native' >>.bashrc \
 && echo 'export YARN_CONF_DIR=$SPARK_HOME/conf' >>.bashrc \
 && echo 'export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin' >>.bashrc

# authorized_keys already create in ubjava_img to enable containers connect to each other via passwordless ssh

COPY create_conf_files_spark.sh .
COPY run_spark.sh .
COPY stop_spark.sh .

RUN chmod +x create_conf_files_spark.sh run_spark.sh stop_spark.sh

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 10000 7077 4040 8080 8081 8082

CMD ["/usr/bin/supervisord"]
