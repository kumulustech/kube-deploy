#!/bin/bash
kubectl config set-cluster kube-do --server=http://${1}:8080
kubectl config set-context kube-do --cluster=kube-do
kubectl config use-context kube-do
