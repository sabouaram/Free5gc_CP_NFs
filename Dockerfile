FROM golang:1.14.4-stretch AS builder
ARG NF_NAME
ARG PORT

#Getting Free5GC and installing required go packages
#Latest version support http traffic redirecting in a kubernetes cluster
RUN cd $GOPATH/src \
    && git clone --recursive -b v3.0.3 -j `nproc` https://github.com/free5gc/free5gc.git \
    && cd free5gc \
    && git checkout master \
    && git submodule sync \
    && git submodule update --init --jobs `nproc` \
    && git submodule foreach git checkout master \
    && git submodule foreach git pull --jobs `nproc` \
    && go mod download 


#Building NFs Binaries
RUN cd $GOPATH/src/free5gc/src/ \
    && if [ "$NF_NAME" = "webconsole" ] ; then mkdir ../bin && cp -R ../$NF_NAME/ ../bin && go build -o ../bin/$NF_NAME/server ../bin/$NF_NAME/server.go ; else go build -o ../bin/$NF_NAME $NF_NAME/$NF_NAME.go ; fi 

######################################## Free5gc NFs Lightweight Docker images ###############################################################

FROM ubuntu:18.04

#Creating Directories
WORKDIR /free5gc

#Copy NFs Binaries from builder, and creating needed directories 
RUN mkdir config/
COPY --from=builder /go/src/free5gc/bin/${NF_NAME} ./
EXPOSE $PORT
  
#################################################################################################################################






