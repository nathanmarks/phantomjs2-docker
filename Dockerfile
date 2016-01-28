FROM ubuntu:14.04

# Dependencies we just need for building phantomjs
ENV buildDependencies\
  wget bzip2

# Dependencies we need for running phantomjs
ENV phantomJSDependencies\
  libicu-dev libfontconfig1-dev libjpeg-dev libfreetype6

# Installing phantomjs
RUN \
    # Installing dependencies
    apt-get update -yqq \
&&  apt-get install -fyqq ${buildDependencies} ${phantomJSDependencies}\
    # Downloading src, unzipping & removing zip
&&  mkdir phantomjs \
&&  cd phantomjs \
&&  wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
&&  bunzip2 phantomjs-2.1.1-linux-x86_64.tar.bz2 \
&&  tar -xvf phantomjs-2.1.1-linux-x86_64.tar \
&&  rm -rf /phantomjs/phantomjs-2.1.1-linux-x86_64.tar \
    # Building phantom
&&  cd phantomjs-2.1.1-linux-x86_64/ \
    # Removing everything but the binary
&&  ls -A | grep -v bin | xargs rm -rf \
    # Symlink phantom so that we are able to run `phantomjs`
&&  ln -s /phantomjs/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs \
&&  ln -s /phantomjs/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs \
&&  ln -s /phantomjs/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/phantomjs \
    # Removing build dependencies, clean temporary files
&&  apt-get purge -yqq ${buildDependencies} \
&&  apt-get autoremove -yqq \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    # Checking if phantom works
&&  phantomjs -v

CMD \
    echo "phantomjs binary is located at /phantomjs/phantomjs-2.1.1-linux-x86_64/bin/phantomjs"\
&&  echo "just run 'phantomjs' (version `phantomjs -v`)"