#####################################################################################
# Compile this dockerfile with
#        time sudo docker build -t hvoss49/pyonline:latest -f Dockerfile .
# Run docker image
#       sudo docker run -d -p 3000:3000 --rm --name pyonline hvoss49/pyonline:latest
#####################################################################################
# Latex-Online container

MAINTAINER Herbert Voss herbert@voss.mobi

# Install git & Node.JS
RUN apt-get clean && apt-get update && apt-get install -y git-core nodejs npm && rm -rf /var/lib/apt/lists/*

COPY ./util/docker-entrypoint.sh /

EXPOSE 2701
CMD ["./docker-entrypoint.sh"]

