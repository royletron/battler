FROM node:14-buster as base
WORKDIR /usr/src

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
RUN npm run export

FROM petrosagg/balena-wpe:raspberrypi3-094d55a

COPY udev-rules/ /etc/udev/rules.d/
COPY --from=base /usr/src/out /var/lib/public_html

ENV WPE_URL="file:///var/lib/public_html/index.html"

COPY wpe-init /wpe-init
RUN chmod +x /wpe-init

CMD [ "/wpe-init" ]

ENV TOHORA_VERSION=0.3.2
RUN wget -O tohora.tgz \
    "https://github.com/mozz100/tohora/releases/download/v"$TOHORA_VERSION"/tohora_"$TOHORA_VERSION"_Linux_armv5.tar.gz" \
    && tar xzf tohora.tgz \
    && rm tohora.tgz
