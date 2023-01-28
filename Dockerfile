FROM nvcr.io/nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu22.04

# Install OS packages
ARG PYTHON_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    git-core \
    unzip \
    zsh \
    poppler-utils \
    python3-setuptools \
    libgl1-mesa-glx \
    libglib2.0-0 \
    python${PYTHON_VERSION} \
    python${PYTHON_VERSION}-dev \
    python${PYTHON_VERSION}-distutils \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/tmp/* /var/lib/apt/lists/*

# Set the default python version
RUN update-alternatives --install /usr/bin/python python /usr/bin/python${PYTHON_VERSION} 1 \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${PYTHON_VERSION} 1

WORKDIR /tmp

# Install pip
ARG PIP_VERSION
RUN wget https://github.com/pypa/pip/archive/refs/tags/${PIP_VERSION}.zip \
    && unzip ${PIP_VERSION}.zip \
    && cd pip-${PIP_VERSION} \
    && python setup.py install

# Install pytorch & torchvision
ARG CUDA_VERSION
ARG PYTORCH_VERSION
ARG TORCHVISION_VERSION
RUN --mount=type=cache,target=/root/.cache \
    pip install torch==${PYTORCH_VERSION}+${CUDA_VERSION} \
    torchvision==${TORCHVISION_VERSION}+${CUDA_VERSION} \
    -f https://download.pytorch.org/whl/${CUDA_VERSION}/torch_stable.html

WORKDIR /root

# Install invoke.ai
ARG INVOKE_AI_VERSION
RUN git clone https://github.com/invoke-ai/InvokeAI.git \
    && cd ./InvokeAI && git checkout ${INVOKE_AI_VERSION} \
    && pip install -r environments-and-requirements/requirements-base.txt

WORKDIR /root/InvokeAI

RUN cd scripts \
    && ln -s ../ldm ldm \
    && ln -s ../backend backend \
    && ln -s ../frontend frontend \
    && ln -s ../static scripts

RUN python scripts/configure_invokeai.py -y

COPY ./entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT sh /usr/bin/entrypoint.sh
