FROM python:3.7-slim

# For opencv
RUN apt-get update && apt-get install -y ffmpeg libsm6 libxext6

# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook
RUN pip install openvino numpy==1.19 ipywidgets pyyaml matplotlib voila opencv-python

# create user with a home directory
ENV USER jovyan
ENV HOME /home/jovyan

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid 1000 \
    jovyan
WORKDIR $HOME


USER jovyan

COPY --chown=jovyan:jovyan . /home/${USER}

EXPOSE 8888

ENV LD_LIBRARY_PATH /usr/local/lib

ENTRYPOINT ["/home/jovyan/entrypoint.sh"]

