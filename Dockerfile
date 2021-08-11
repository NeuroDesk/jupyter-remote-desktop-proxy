ARG GO_VERSION="1.14.4"
ARG SINGULARITY_VERSION="3.7.0"

# Build Singularity.
FROM golang:${GO_VERSION}-buster as builder

# Necessary to pass the arg from outside this build (it is defined before the FROM).
ARG SINGULARITY_VERSION

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        cryptsetup \
        libssl-dev \
        uuid-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://github.com/hpcng/singularity/releases/download/v${SINGULARITY_VERSION}/singularity-${SINGULARITY_VERSION}.tar.gz" \
    | tar -xz \
    && cd singularity \
    && ./mconfig -p /usr/local/singularity --without-suid \
    && cd builddir \
    && make \
    && make install


FROM jupyter/base-notebook:python-3.7.6
ENTRYPOINT [ "executable" ]

USER root

# Install singularity into the final image.
COPY --from=builder /usr/local/singularity /usr/local/singularity

# RUN apt-get -y update \
#  && apt-get install -y dbus-x11 \
#    firefox \
#    xfce4 \
#    xfce4-panel \
#    xfce4-session \
#    xfce4-settings \
#    xorg \
#    xubuntu-icon-theme

RUN apt-get -y update \
 && apt-get install -y dbus-x11 \
   firefox \
   lxde \
   xorg

# Remove light-locker to prevent screen lock
ARG TURBOVNC_VERSION=2.2.6
RUN wget -q "https://sourceforge.net/projects/turbovnc/files/${TURBOVNC_VERSION}/turbovnc_${TURBOVNC_VERSION}_amd64.deb/download" -O turbovnc_${TURBOVNC_VERSION}_amd64.deb && \
   apt-get install -y -q ./turbovnc_${TURBOVNC_VERSION}_amd64.deb && \
   apt-get remove -y -q light-locker && \
   rm ./turbovnc_${TURBOVNC_VERSION}_amd64.deb && \
   ln -s /opt/TurboVNC/bin/* /usr/local/bin/

# apt-get may result in root-owned directories/files under $HOME
RUN chown -R $NB_UID:$NB_GID $HOME

ADD . /opt/install
RUN fix-permissions /opt/install

USER $NB_USER
RUN cd /opt/install && \
   conda env update -n base --file environment.yml
