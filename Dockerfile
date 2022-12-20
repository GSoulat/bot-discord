FROM python:3.7

RUN apt-get update && apt-get -y install cron

WORKDIR /

COPY . .

RUN chmod 0644 /crontab
RUN /crontab /crontab

# run crond as main process of container
CMD ["cron", "-f"]