#!/bin/bash

proxy=http://192.168.0.4:8118
no_proxy=127.0.0.1,localhost,\
192.168.0.6,\
ken-nas,\
192.168.99.0/24,\
ken.metathings.cc,\
192.168.39.0/24,\
10.96.0.0/12,\
index.docker.io,\
registry-mirror-cache-cn.oss-cn-shanghai.aliyuncs.com,\
192.168.99.100

#export https_proxy=${proxy}
#export http_proxy=${proxy}
#export no_proxy=${no_proxy}
#	--docker-env HTTP_PROXY=${proxy} \
#	--docker-env HTTPS_PROXY=${proxy} \
#	--docker-env NO_PROXY=${no_proxy} \

minikube start \
	--kubernetes-version v1.17.0 \
	--registry-mirror http://192.168.0.6:83 \
	--image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers \
	--cpus 4 \
	--memory 8192 \
	--insecure-registry=192.168.0.6:83 \
        --insecure-registry=ken.metathings.cc:83 \
	--insecure-registry=ken-nas:83 \
        --docker-env HTTP_PROXY=${proxy} \
        --docker-env HTTPS_PROXY=${proxy} \
        --docker-env NO_PROXY=${no_proxy}
	

