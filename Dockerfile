FROM ubuntu

# install cron
RUN apt-get update && apt-get install cron -y -qq

RUN echo 'echo `date +"%H:%M:%S"` - This is sample application 1!' > /test.sh && chmod +x /test.sh

# register cron jobs to start the applications and redirects their stdout/stderr
# to the stdout/stderr of the entry process by adding lines to /etc/crontab
RUN echo "*/1 * * * * root /test.sh > /proc/1/fd/1 2>/proc/1/fd/2" >> /etc/crontab
RUN echo "*/1 * * * * root /main.py > /proc/1/fd/1 2>/proc/1/fd/2" >> /etc/crontab

# start cron in foreground (don't fork)
ENTRYPOINT [ "cron", "-f" ]