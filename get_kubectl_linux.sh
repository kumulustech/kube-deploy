export K8S_VERSION=1.2.0-alpha.7
wget http://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kubectl
chmod 755 kubectl
mv kubectl /usr/local/bin/
