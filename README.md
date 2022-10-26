# invoke-ai-docker
<br/>

Setup
-----

This repo requires:

    - make 4.3 or above 
    - docker 20.10 or above
    - docker-compose-plugin 2.12 or above

If you want to run the inference on GPU you also need the latest version of [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)
<br/>

Build & run
-----------

Before build you should login in Hugging Face and download the model ([sd-v1-4.ckpt](https://huggingface.co/CompVis/stable-diffusion-v-1-4-original)) in ./models
<br/>

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
