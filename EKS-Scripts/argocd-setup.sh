#!/bin/bash
set -e

NAMESPACE=argo-cd
RELEASE_NAME=argo

echo "Create argocd namespace"
kubectl create ns ${NAMESPACE} || true

echo "Deploy ArgoCD on EKS"
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm install ${RELEASE_NAME} argo/argo-cd -n ${NAMESPACE} || true

echo "Wait PODs to start"
sleep 2m

echo "Change argocd service to Load Balancer"
kubectl patch svc ${RELEASE_NAME}-argocd-server -n ${NAMESPACE} -p '{"spec": {"type": "LoadBalancer"}}'

echo "Wait to create external IP"
sleep 10s

echo "Print Argocd URL"
kubectl get service ${RELEASE_NAME}-argocd-server -n ${NAMESPACE} | awk '{print $4}'


echo "Print ArgoCD password"
kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" -n ${NAMESPACE} | base64 -d > argo-pass.txt
