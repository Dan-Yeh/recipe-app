FROM python:3.7-alpine
LABEL maintainer="Dan Yeh"

# Make print directly not buffer to avoid errors for python in docker
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
# --no-cache minimize dependencies
RUN apk add --update --no-cache postgresql-client jpeg-dev
# virtual for easy remove
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
# -D: create user only for running app
RUN adduser -D user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user