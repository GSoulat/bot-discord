FROM python:3.10.6

RUN apt update && apt install -y cron vim

WORKDIR /
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
RUN pip install --upgrade pip
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies:
COPY requirements.txt .
RUN pip install -r requirements.txt



# Run the application:
COPY . .

ADD main.py /
RUN chmod a+x main.py
CMD ["/main.py"]