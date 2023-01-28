# `invoke-ai-docker`: Simple and easy [InvokeAI](https://github.com/invoke-ai/InvokeAI) docker setup

<br/>

## Setup
--------
<br/>

* Install the lastest version of Make:
    ```bash
    $ sudo apt update
    $ sudo apt install make
    ```

* Install the latest version of [Docker](https://docs.docker.com/engine/install/ubuntu/) including the `compose plugin`, also requires enabling the [Buildkit](https://docs.docker.com/build/buildkit/) backend

* Install the latest version of the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

* Get the repo:
    ```bash
    $ git clone git@github.com:collectiveai-team/invoke-ai-docker.git
    $ cd invoke-ai-docker
    ```

<br/>

## Build & run
--------------

* Build the docker image:
    ```bash
    $ make build
    ```

* Run the image on `gpu`:
    ```bash
    $ make run
    ```

* Run the image on `cpu`:
    ```bash
    $ make run-cpu
    ```
