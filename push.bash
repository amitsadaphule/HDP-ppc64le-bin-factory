#!/bin/sh

setup_git() {
  git config --global user.email "amits2@us.ibm.com"
  git config --global user.name "Amit Sadaphule"
}

commit_library_files() {
  git clone https://github.com/prestodb/presto-hadoop-apache2.git
  cd presto-hadoop-apache2
  git checkout -b ppc64le_libs
  yes | cp ../out/libhadoop.so src/main/resources/nativelib/Linux-ppc64le/
  yes | cp ../out/libsnappy.so src/main/resources/nativelib/Linux-ppc64le/
  git add src/main/resources/nativelib/Linux-ppc64le/*
  git commit -m "Updated ppc64le libs => Travis build" -m "$TRAVIS_JOB_WEB_URL"
}

upload_files() {
  git remote add upstream https://${GH_TOKEN}@github.com/amitsadaphule/presto-hadoop-apache2.git > /dev/null 2>&1
  git push --quiet --set-upstream upstream ppc64le_libs
}

setup_git
commit_library_files
upload_files
