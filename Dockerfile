FROM nvcr.io/nvidia/cuda:11.7.1-runtime-ubuntu22.04

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# OS packages
ARG PYTHON_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    git-core \
    unzip \
    python3-setuptools \
    libgl1-mesa-glx \
    libglib2.0-0 \
    python${PYTHON_VERSION} \
    python${PYTHON_VERSION}-dev \
    python${PYTHON_VERSION}-distutils \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/tmp/* /var/lib/apt/lists/*

# Set default python version
RUN update-alternatives --install /usr/bin/python python /usr/bin/python${PYTHON_VERSION} 1 \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${PYTHON_VERSION} 1

WORKDIR /tmp

# Install pip
ARG PIP_VERSION
RUN wget https://github.com/pypa/pip/archive/refs/tags/${PIP_VERSION}.zip \
    && unzip ${PIP_VERSION}.zip \
    && cd pip-${PIP_VERSION} \
    && python setup.py install

# Install pytorch
ARG CUDA_VERSION
ARG PYTORCH_VERSION
RUN --mount=type=cache,target=/root/.cache \
    pip install torch==${PYTORCH_VERSION}+${CUDA_VERSION} \
    -f https://download.pytorch.org/whl/${CUDA_VERSION}/torch_stable.html

WORKDIR /root

# Install invoke.ai
ARG INVOKE_AI_VERSION
RUN git clone https://github.com/invoke-ai/InvokeAI.git \
    && cd ./InvokeAI && git checkout ${INVOKE_AI_VERSION} \
    && pip install -r requirements.txt \
    && python scripts/preload_models.py

# Copy the model
ARG MODEL_NAME
COPY ./models/${MODEL_NAME} InvokeAI/models/ldm/stable-diffusion-v1/model.ckpt

COPY ./entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT sh /usr/bin/entrypoint.sh
