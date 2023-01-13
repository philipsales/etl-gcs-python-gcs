# Deployment Instructions for OPENREFINE #

## Hardware Server Requirements ##
1. Single vm for the master node 
    ```
    Standard / Shared CPU / 2vCPU / 16 GB Memory / 20 GB Disk / SGP1 - Ubuntu 18.04.3 (LTS) x64
    ```

## Operation System Requirements ##
1. Master and Data Nodes
    ```
    NAME="Ubuntu Linux"
    VERSION="18.04.3 (Core)"
    ID="debian"
    ID_LIKE="bionic beaver"
    VERSION_ID="18"
    PRETTY_NAME="Ubuntu LTS (Core)"

    arch: 3.10.0-1062.18.1.el7.x86_64
    cpu MHz:  2500.000 
    MemTotal: 1843112 kB (1.8GB RAM)
    ```


## Create Openrefine user ##

1. create user for **all nodes**
    ```
    $ sudo adduser openrefine 
    $ sudo usermod -aG sudo openrefine 
    ```
    **Note: OpenRefine user is sudoer*
    **Note: User password is op3nr3fin3@2020

1. Log out and log back to host machine


## Installation of Google Cloud SDK ##

1. Use openrefine user
    ```
    sudo su - openrefine
    ```

1. Download Cloud SDK
    ```
    $ wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-288.0.0-linux-x86_64.tar.gz 
    $ tar -xzvf ..
    $ rm google-cloud-sdk-288.0.0-linux-x86_64.tar.gz  
    ```

Use the install script to add Cloud SDK tools to your path.
    ```
    $ cd /home/openrefine/
    $ ./google-cloud-sdk/install.sh
    ```
    note: answer `N` to all prompt

    #$ ->error- ./google-cloud-sdk/bin/gcloud init 

    ```
    $ gcloud init --console-only
    $ gcloud config set accessibility/screen_reader true
    ```
    enter project id: dev-medcheck-pipeline

1. Configure Google Cloud Console in website platform
    Enable Google Cloud API
    Enable Cloud Resource Manager API
    Generate IAM user for openrefine (i.e. dev-openrefine-api@dev-medchek-pipeline.iam.gserviceaccount.com)
    - Download the key-file


## Installation of  dependencies ##
   
1. Use openrefine user
    ```
    sudo su - openrefine
    ```

1. install git
    ```
    sudo apt update
    sudo apt-get install git
    ```

1. pull install from repository 
    ```
    $ git clone https://gitlab.medcheck.com.ph/data-engineer/openrefine-client-api.git openrefine-client-api
    ```

1. grant scripts permission 
    ```
    $ cd openrefine-api/scripts
    $ chmod u+x *.sh
    ```

1. set environment
    ```
    $ touch .env
    ```
    note: copy the environment template in repository and paste in .env file
    - change the location for GOOGLE_APPLICATION_CREDENTIALS
    - change the location for APP_API_SRC_FOLDER 
    - change the location for OR_OPENREFINE_DATA_DIR 

1. set google credential password
    ```
    $ cd ~/home/openrefine/openrefine-client-api
    $ mkdir secrets
    $ touch dev-medchek-pipeline-9390dbeea154.json
    ```
    note: copy the credentials in repository and paste in .json file

1. install docker
    ```
    $ ./install_docker.sh
    ``    
    **Note: OpenRefine user is sudoer*
    **Note: User password is op3nr3fin3@2020

## Set Google SDK credentils ##

1. Set Google Cloud auth credentials using scripts 
    ```
    $ cd openrefine-api/scripts
    $ source ./set_google_cloud_auth.sh
    ```

1. set the Googel SDK in Path 

    add in bottom file of your ~/.bashrc
    ```
    $ export GOOGLE_APPLICATION_CREDENTIALS=/home/openrefine/openrefine-client-api/secrets/dev-medchek-pipeline-9390dbeea154.json
    ```
1. Source the additional script
    ```
    $ source ~/.bashrc
    ```

## Installation of OpenRefine API service ##

1. Install Python 
    ```
    $ sudo apt update
    $ sudo apt install -y python3-pip
    ```

1. Install Pyenv 
    ```
    $ curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    $ exec "$SHELL"
    ```

1. Install Pyenv as source in .bashrc
    ```
    $ vi ~/.bashrc
    ```
    note: enter the following in the bottom of the file

    ```
    export PATH="/home/openrefine/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    ```

1. Source the additional script
    ```
    $ source ~/.bashrc
    ```

1. Install Python dependencies and specific version 
    ```
    $ sudo apt-get install -y build-essential git libreadline-dev zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev
    $ pyenv install 3.6.2
    $ pyenv global 3.6.2                 
    $ pyenv virtualenv  openrefine-python3.6_env
    ```


## Run the of OpenRefine API service ##
1. Activate virtual enviroment 
    ```
    $ pyenv activate  openrefine-python3.6_env
    ```

1. Install dependencies
    ```
    $ cd /home/openrefine/openrefine-client-api
    $ pip install -r requirements.txt
    ```

1. Run the API manually 
    ```
    $ cd /home/openrefine/openrefine-api
    $ python -B src/app.py
    ```


1. Open browser
    ```
    http://0.0.0.0:5000/api/ui/
    ```
