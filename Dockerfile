FROM ubuntu:14.04

RUN apt-get update && apt-get install -y wget unzip python build-essential g++ flex bison gperf ruby perl libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev libpng-dev libjpeg-dev

RUN mkdir phantomjs && cd phantomjs && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.0.0-source.zip && unzip phantomjs-2.0.0-source.zip

RUN cd phantomjs/phantomjs-2.0.0/ && yes | ./build.sh
CMD echo "phantomjs binary is inside container at phantomjs/phantomjs-2.0.0/bin/phantomjs"
