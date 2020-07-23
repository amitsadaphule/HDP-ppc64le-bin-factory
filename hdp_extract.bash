#!/bin/bash

HDP_SERIES=2.x
HDP_VERSION=2.6.1.0
HDP_VERSION_MINOR=129
HADOOP_RPM_VERSION=2_6_1_0_$HDP_VERSION_MINOR-2.7.3.2.6.1.0-$HDP_VERSION_MINOR
LIBHADOOP_VERSION=1.0.0
LIBSNAPPY_VERSION=1.1.4

mkdir hdp hadoop out
cd hdp
wget -q http://public-repo-1.hortonworks.com/HDP/centos7-ppc/$HDP_SERIES/updates/$HDP_VERSION/HDP-$HDP_VERSION-centos7-ppc-rpm.tar.gz
tar xzf HDP-$HDP_VERSION-centos7-ppc-rpm.tar.gz
cd ..
cp ./hdp/HDP/centos7-ppc/hadoop/hadoop_$HADOOP_RPM_VERSION.ppc64le.rpm ./hadoop/
cd hadoop
rpm2cpio hadoop_$HADOOP_RPM_VERSION.ppc64le.rpm | cpio -idm
cd ..
cp hadoop/usr/hdp/$HDP_VERSION-$HDP_VERSION_MINOR/hadoop/lib/native/libhadoop.so.$LIBHADOOP_VERSION out/libhadoop.so
cp hadoop/usr/hdp/$HDP_VERSION-$HDP_VERSION_MINOR/hadoop/lib/native/libsnappy.so.$LIBSNAPPY_VERSION out/libsnappy.so
rm -rf hdp hadoop
