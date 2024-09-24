# Install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# Create the folder that will be copied into the control plane.
mkdir -p ~/.minikube/files/etc/ca-certificates/

# Set the sops age private key
export SOPS_AGE_KEY='' # replace with your age private key

# Decrypt the token.csv file
sops --decrypt -i token.csv

# Copy the token file into the folder.
cp token.csv ~/.minikube/files/etc/ca-certificates/token.csv

# Start the minikube / Same command in Windows
minikube start --driver docker --container-runtime docker --gpus all --extra-config=apiserver.token-auth-file=/etc/ca-certificates/token.csv --addons metrics-server

# Set GitHub personal access token and username:
export GITHUB_TOKEN=''
export GITHUB_USER=''