FROM ubuntu:14.04

RUN sudo apt-get update
RUN sudo apt-get upgrade -y

# Install HHVM

RUN sudo apt-get install software-properties-common -y
RUN sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN sudo add-apt-repository 'deb http://dl.hhvm.com/ubuntu trusty main'
RUN sudo apt-get update
RUN sudo apt-get install hhvm-dev -y

# Install Mongo fill
RUN sudo apt-get install git-core automake autoconf libtool gcc git -y

RUN git clone git://github.com/mongodb/libbson.git
WORKDIR libbson
RUN ./autogen.sh
RUN make
RUN sudo make install

WORKDIR ..
RUN git clone https://github.com/mongofill/mongofill-hhvm
WORKDIR mongofill-hhvm
RUN ./build.sh

RUN mkdir /etc/hhvm/ext
RUN mv mongo.so /etc/hhvm/ext/mongo.so

WORKDIR /etc/hhvm
RUN echo "hhvm.dynamic_extension_path = /etc/hhvm/ext\n" >> php.ini
RUN echo "hhvm.dynamic_extension[mongo] = mongo.so\n" >> php.ini

VOLUME /var/www/html

EXPOSE 9000

CMD ["/usr/bin/hhvm", "-m", "server", "-vServer.Type=fastcgi", "-vServer.Port=9000"]
