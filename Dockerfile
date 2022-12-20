FROM ubuntu

RUN apt-get install -y python cron
ADD my-crontab /
ADD main.py /
RUN chmod a+x main.py

RUN crontab /my-crontab
ENTRYPOINT cron -f