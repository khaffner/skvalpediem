FROM mcr.microsoft.com/powershell:ubuntu-18.04

RUN apt-get update >/dev/null
RUN apt-get install -y net-tools vnstat vnstati >/dev/null

RUN vnstat --create -i eth0

SHELL [ "pwsh","-Command" ]
RUN Install-Module Universaldashboard.Community -Force -AcceptLicense

ADD . /home/pi/code/skvalpediem/

CMD [ "pwsh","-command","& ./home/pi/code/skvalpediem/Run.ps1" ]