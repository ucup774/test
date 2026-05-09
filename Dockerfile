# Image ringan & cepat
FROM python:3.11-slim

USER root

ENV DEBIAN_FRONTEND=noninteractive

# Install package seperlunya aja
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    curl \
    wget \
    git \
    nano \
    htop \
    tmux \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip biar install lebih cepat
RUN pip install --no-cache-dir --upgrade pip

# Install Jupyter minimal
RUN pip install --no-cache-dir \
    notebook==6.5.6 \
    jupyter-server-proxy \
    jupyterlab

# User default Binder
ARG NB_USER=jovyan
ARG NB_UID=1000

ENV USER=${NB_USER}
ENV HOME=/home/${NB_USER}

RUN useradd -m -s /bin/bash -N -u ${NB_UID} ${NB_USER}

# Passwordless sudo
RUN echo "${NB_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${NB_USER}
WORKDIR ${HOME}

# Auto create workspace
RUN mkdir -p ${HOME}/workspace

# Expose port
EXPOSE 8888

# CMD simple & cepat boot
CMD ["jupyter", "notebook", \
"--ip=0.0.0.0", \
"--port=8888", \
"--no-browser", \
"--NotebookApp.token=''", \
"--NotebookApp.password=''", \
"--NotebookApp.allow_origin='*'"]
