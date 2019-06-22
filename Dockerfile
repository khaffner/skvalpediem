FROM mcr.microsoft.com/powershell:ubuntu-18.04

RUN useradd -m pi

RUN apt-get update >/dev/null
RUN apt-get install -y net-tools >/dev/null

USER pi
WORKDIR /home/pi

SHELL [ "pwsh","-Command" ]
RUN Install-Module Universaldashboard.Community -Force -AcceptLicense

EXPOSE 8080