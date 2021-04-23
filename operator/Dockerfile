FROM debian
#RUN apt-get update -y && apt-get install —no-install-recommends -y -q curl build-essential ca-certificates
RUN apt-get update -y && apt-get install -y ca-certificates
COPY ./cd-mgr /cd-mgr
CMD /cd-mgr