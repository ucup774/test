FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
USER root
RUN apt-get update && apt-get install -y sudo curl wget git vim python3 python3-pip jupyter-notebook && rm -rf /var/lib/apt/lists/*
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}
RUN adduser --disabled-password --gecos "" --uid ${NB_UID} ${NB_USER}
RUN echo "${NB_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ${NB_USER}
WORKDIR ${HOME}
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''"]
