FROM python:3.7-alpine
LABEL maintainer="Dan Yeh"

# Make print directly not buffer to avoid errors for python in docker
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# -D: create user only for running app
RUN adduser -D user
USER user