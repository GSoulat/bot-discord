FROM python:3.10.6

COPY main /bin/main
COPY root /var/spool/cron/crontabs/root
RUN chmod +x /bin/main
CMD crond -l 2 -f