FROM node:8-alpine

RUN apk add --no-cache -U --virtual .build-deps \
        git \
	python \
	make \
	g++ \
 && npm config set user root \
 && npm install -g joplin \
 && apk del .build-deps
RUN apk add --no-cache -U jq socat
RUN mkdir -p /joplin/profile \
 && chown node:node /joplin/profile

COPY runtime.sh /
USER node

VOLUME /joplin/profile

ENTRYPOINT ["/runtime.sh"]
