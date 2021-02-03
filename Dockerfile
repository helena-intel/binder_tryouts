FROM python:3.7-slim
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook
RUN pip install openvino numpy==1.19 ipywidgets pyyaml matplotlib voila

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

USER root
COPY . /home/${USER}
RUN chown -R ${USER} /home/${USER}
USER ${USER}

EXPOSE 8888

ENTRYPOINT ["/home/jovyan/entrypoint.sh"]

