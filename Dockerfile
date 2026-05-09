FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

USER root

# Install tools inti + build essential
RUN apt-get update && apt-get install -y \
    sudo curl wget git vim python3 python3-pip \
    bash-completion build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter + Terminal Handler + Server Proxy
RUN pip3 install --no-cache-dir \
    notebook==6.4.12 \
    terminado \
    jupyter-server-proxy \
    jupyter-console

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password --gecos "" --uid ${NB_UID} ${NB_USER}
RUN echo "${NB_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${NB_USER}
WORKDIR ${HOME}

# Maksa Terminal diizinkan dan default shell ke BASH
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.disable_check_xsrf=True", "--NotebookApp.terminado_settings={'shell_command': ['/bin/bash']}"]
