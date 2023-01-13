#!/bin/bash
#source ./google_cloud.sh

if ! [ -x "$(command -v gcloud)" ]; then
  echo 'Error: gcloud is not installed. After install (https://cloud.google.com/sdk/docs/quickstart-linux) open new shell.' >&2
  #exit 1
fi

### set env variables
cd "$pwd"

# Download Google Cloud Sdk
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-288.0.0-linux-x86_64.tar.gz 
tar -xzvf google-cloud-sdk-288.0.0-linux-x86_64.tar.gz 

# Install Google Cloud Sdk
./google-cloud-sdk/install.sh -q
#./google-cloud-sdk/bin/gcloud init

# Authenticate Google Cloud Sdk
#eval export GOOGLE_APPLICATION_CREDENTIALS="/openrefine-api/dev-medchek-pipeline-9390dbeea154.json"
#./google-cloud-sdk/bin/gcloud auth activate-service-account --key-file=/openrefine-api/dev-medchek-pipeline-9390dbeea154.json
eval export GOOGLE_APPLICATION_CREDENTIALS="prod-gcs-colab@reach52-dataops.iam.gserviceaccount.com.json"
./google-cloud-sdk/bin/gcloud auth activate-service-account --key-file=../secrets/prod-gcs-colab@reach52-dataops.iam.gserviceaccount.com.json