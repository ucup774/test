FROM python:3.9-slim-buster

USER root

# Pas fase build, kita install semuanya
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    vim \
    net-tools \
    build-essential \
    tmate \
    && rm -rf /var/lib/apt/lists/*

# Download proot biar langsung ada di sistem
RUN wget https://proot.me/static/proot-x86_64 -O /usr/local/bin/proot \
    && chmod +x /usr/local/bin/proot

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}
RUN adduser --disabled-password --gecos "" --uid ${NB_UID} ${NB_USER}

USER ${NB_USER}
WORKDIR ${HOME}

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''"]
