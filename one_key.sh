#!/bin/bash

top_dir=$(readlink -f $(dirname "${BASH_SOURCE[0]}"))

your_registry=192.168.0.6:83/cloud-native-demo
cd ${top_dir}/demos/elastic_inference/kubernetes
${top_dir}/demos/elastic_inference/tools/gen-k8s-yaml.sh -r ${your_registry} -f elastic-inference.yaml.template
kubectl apply -f .

cd ${top_dir}/demos/elastic_inference/kubernetes/monitoring
kubectl apply -f .

cd ${top_dir}/demos/elastic_inference/kubernetes/sample-infer
${top_dir}/demos/elastic_inference/tools/gen-k8s-yaml.sh -r ${your_registry} -f sample-car.yaml.template
${top_dir}/demos/elastic_inference/tools/gen-k8s-yaml.sh -r ${your_registry} -f sample-face.yaml.template
${top_dir}/demos/elastic_inference/tools/gen-k8s-yaml.sh -r ${your_registry} -f sample-people.yaml.template
kubectl apply -f .

cd ${top_dir}/kube-prometheus/
kubectl apply -f manifests/setup/
kubectl apply -f manifests/

cd ${top_dir}
./create_key_for_operator.sh

cd ${top_dir}/k8s-prometheus-adapter
kubectl apply -f deploy/manifests/

cd ${top_dir}/demos/elastic_inference/kubernetes/scale
kubectl apply -f hpa-infer-people-on-custom-metric-scale-ratio.yaml