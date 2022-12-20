FROM ubuntu
RUN apt-get update && apt-get install -y software-properties-common python-software-properties && apt-get update

RUN apt-get install -y python cron
ADD my-crontab /
ADD main.py /
RUN chmod a+x main.py

RUN crontab /my-crontab
ENTRYPOINT cron -f