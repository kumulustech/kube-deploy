export K8S_VERSION=1.2.0-alpha.7
curl http://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/darwin/amd64/kubectl > kubectl
chmod 755 kubectl
mv kubectl /usr/local/bin/
