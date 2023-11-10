FROM ubuntu:22.04

RUN apt update && apt install -y curl git zip unzip clang cmake ninja-build pkg-config libgtk-3-dev nano

RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer/

RUN git clone -b stable https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"

RUN git clone https://github.com/meeper001/embedded_hmi_flutter.git

WORKDIR /home/developer/embedded_hmi_flutter

RUN flutter doctor
RUN flutter pub global activate flutterpi_tool
ENV PATH "$PATH:/home/developer/.pub-cache/bin"

RUN flutter pub get
RUN flutterpi_tool precache