#!/bin/bash
set -e

# Pull image from upstream:
# docker pull hvoss49/ltxonline

pushd "$(dirname $0)" > /dev/null
# git root directory
GIT_ROOT=$(git rev-parse --show-toplevel)
popd > /dev/null
docker run \
    -ti                         `: # attach pseudo-tty and interactive mode. Make Ctrl-C exit container` \
    --rm                        `: # remove container on exit` \
    --name latexdev             `: # name container latex` \
    -v $GIT_ROOT/:/src          `: # mount current code into /src folder` \
    -w /src                     `: # use /src as a working directory` \
    -p 2701:2701                `: # bind host port 2701 to containers 2701` \
    --env NODE_ENV='development'`: # launch in DEV environment` \
    --env PORT=2701             `: # define service HTTP port` \
    hvoss49/ltxonline           `: # run image latex2` \
    /bin/bash -c "node node_modules/nodemon/bin/nodemon.js -e js,jade app.js"
