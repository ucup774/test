FROM python:3.9-slim-buster

USER root

# Install tools inti + tmate buat remote access dari Termux lu
RUN apt-get update && apt-get install -y \
    sudo curl wget git vim net-tools \
    build-essential tmate \
    && rm -rf /var/lib/apt/lists/*

# Download PRoot pas fase build (Pasti Berhasil)
RUN wget https://proot.me/static/proot-x86_64 -O /usr/local/bin/proot \
    && chmod +x /usr/local/bin/proot

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}
RUN adduser --disabled-password --gecos "" --uid ${NB_UID} ${NB_USER}

# Kasih izin eksekusi script di home
RUN chown -R ${NB_USER}:${NB_USER} ${HOME}

USER ${NB_USER}
WORKDIR ${HOME}

# Langsung jalankan jupyter
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''"]
