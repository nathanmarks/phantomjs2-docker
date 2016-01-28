FROM ubuntu:14.04

# Dependencies we just need for building phantomjs
ENV buildDependencies\
  wget unzip python build-essential g++ flex bison gperf\
  ruby perl libsqlite3-dev libssl-dev libpng-dev git

# Dependencies we need for running phantomjs
ENV phantomJSDependencies\
  libicu-dev libfontconfig1-dev libjpeg-dev libfreetype6

# Installing phantomjs
RUN \
    # Installing dependencies
    apt-get update -yqq \
&&  apt-get install -fyqq ${buildDependencies} ${phantomJSDependencies}\
    # Building phantom
&&  git clone git://github.com/ariya/phantomjs.git \
&&  cd phantomjs \
&&  git checkout 2.1.1 \
&&  git submodule init \
&&  git submodule update \
&&  python build.py \
    # Removing everything but the binary
&&  ls -A | grep -v bin | xargs rm -rf \
    # Symlink phantom so that we are able to run `phantomjs`
&&  ln -s /phantomjs/bin/phantomjs /usr/local/share/phantomjs \
&&  ln -s /phantomjs/bin/phantomjs /usr/local/bin/phantomjs \
&&  ln -s /phantomjs/bin/phantomjs /usr/bin/phantomjs \
    # Removing build dependencies, clean temporary files
&&  apt-get purge -yqq ${buildDependencies} \
&&  apt-get autoremove -yqq \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    # Checking if phantom works
&&  phantomjs -v

CMD \
    echo "phantomjs binary is located at /phantomjs/phantomjs-2.1.1/bin/phantomjs"\
&&  echo "just run 'phantomjs' (version `phantomjs -v`)"
