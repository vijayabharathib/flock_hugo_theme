FROM starefossen/ruby-node:2-8-slim
# Forked from https://github.com/publysher/docker-hugo
# Download and install hugo
RUN apt-get -qq update \
    && apt-get -qq install wget
ENV HUGO_VERSION 0.31.1
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.deb
RUN wget -P /tmp/ https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} 
RUN dpkg -i /tmp/${HUGO_BINARY} \
    && rm /tmp/${HUGO_BINARY}

# Create working directory
RUN mkdir /usr/share/flock
WORKDIR /usr/share/flock
COPY package.json /usr/share/flock
RUN yarn install 
COPY . /usr/share/flock
# Expose default hugo port
EXPOSE 1313

# By default, serve site
ENV HUGO_BASE_URL http://localhost:1313
