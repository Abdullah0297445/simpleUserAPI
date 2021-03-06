FROM python:3.7-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir -p /home/simpleUserAPI
WORKDIR /home/simpleUserAPI


RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev

COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache

RUN apk del .tmp-build-deps

COPY . .

RUN addgroup -S dev
RUN adduser -S simpleapiuser -G dev

RUN chown -R simpleapiuser:dev /home/simpleUserAPI
RUN chmod 755 /home/simpleUserAPI

USER simpleapiuser

RUN chmod +x scripts/entrypoint.sh
ENTRYPOINT ["/home/simpleUserAPI/scripts/entrypoint.sh"]