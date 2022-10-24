# invoke-ai-docker

Setup
-----

This repo requires [docker](https://docs.docker.com/engine/install/ubuntu/) 20.10 or above and docker-compose-plugin 2.12 or above

You also need the latest version of [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

<br/>


Build & run
---------------------

##### Build
```bash
$ make build
```
##### Run on GPU
```bash
$ make run
```
##### Run on CPU
```bash
$ make run-cpu
```
