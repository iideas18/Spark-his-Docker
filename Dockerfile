# base image
FROM openjdk:8

# define spark and hadoop versions
ENV SPARK_VERSION=2.4.5
ENV HADOOP_VERSION=3.1.4

# download and install hadoop
RUN mkdir -p /opt && \
    cd /opt && \
    curl http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | \
        tar -zx hadoop-${HADOOP_VERSION}/lib/native && \
    ln -s hadoop-${HADOOP_VERSION} hadoop && \
    echo Hadoop ${HADOOP_VERSION} native libraries installed in /opt/hadoop/lib/native

# download and install spark
RUN mkdir -p /opt && \
    cd /opt && \
    curl http://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz | \
        tar -zx && \
    ln -s spark-${SPARK_VERSION}-bin-hadoop2.7 spark && \
    echo Spark ${SPARK_VERSION} installed in /opt

ENV PATH $PATH:/opt/spark/bin:
ENV SPARK_HOME=/opt/spark

ADD spark-master spark-worker /opt/spark/bin/
ADD spark-defaults.conf /opt/spark/conf/spark-defaults.conf
ADD spark-env.sh /opt/spark/conf/spark-env.sh
RUN mkdir /opt/spark/applicationHistory

#For Windows
RUN sed -i -e 's/\r$//' /opt/spark/bin/spark-master
RUN sed -i -e 's/\r$//' /opt/spark/bin/spark-worker
RUN sed -i -e 's/\r$//' /opt/spark/conf/spark-defaults.conf
RUN sed -i -e 's/\r$//' /opt/spark/conf/spark-env.sh

