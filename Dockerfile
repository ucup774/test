# Pake base python slim biar build ngebut parah
FROM python:3.9-slim-buster

USER root

# Install tools minimalis biar gak timeout
RUN apt-get update && apt-get install -y \
    sudo curl wget git \
    && rm -rf /var/lib/apt/lists/*

# Install notebook versi stabil & jupyter-server-proxy
RUN pip install --no-cache-dir notebook==6.4.12 jupyter-server-proxy

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password --gecos "" --uid ${NB_UID} ${NB_USER}
RUN echo "${NB_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${NB_USER}
WORKDIR ${HOME}

# Entrypoint super simple biar bypass timeout
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''"]
