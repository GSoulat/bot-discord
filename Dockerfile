# Python Base Image
FROM python:3.10.6
# install cron
RUN apt-get update && apt-get install cron -y -qq

RUN echo 'echo `date +"%H:%M:%S"` - This is sample application 1!' > /main.py && chmod +x /main.py

# register cron jobs to start the applications and redirects their stdout/stderr
# to the stdout/stderr of the entry process by adding lines to /etc/crontab
RUN echo "* * * * * root /main.py > /proc/1/fd/1 2>/proc/1/fd/2" >> /etc/crontab

# start cron in foreground (don't fork)
ENTRYPOINT [ "cron", "-f" ]