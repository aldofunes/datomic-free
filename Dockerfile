FROM openjdk:8u212-jre
MAINTAINER "Aldo Funes <aldofunes88@gmail.com>"

ENV DATOMIC_VERSION 0.9.5703

RUN wget https://my.datomic.com/downloads/free/${DATOMIC_VERSION} -qO /tmp/datomic.zip \
  && unzip /tmp/datomic.zip \
  && rm /tmp/datomic.zip \
  && mv /datomic-free-${DATOMIC_VERSION} /datomic

WORKDIR /datomic

RUN cp config/samples/free-transactor-template.properties config/transactor.properties

RUN sed "s/host=localhost/host=0.0.0.0/" -i config/transactor.properties

RUN mkdir /data
RUN sed "s/# data-dir=data/data-dir=\/data/" -i config/transactor.properties

RUN mkdir /log
RUN sed "s/# log-dir=log/log-dir=\/log/" -i config/transactor.properties

EXPOSE 4334 4335 4336 8001

CMD ["/datomic/bin/transactor", "/datomic/config/transactor.properties"]
