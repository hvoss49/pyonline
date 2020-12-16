#!/bin/bash
set -e

# Cleanup www folder
rm -rf /var/www/pyonline
# Copy and install the latest & greatest Latex-Online
cp -r /usr/local/src/pyonline /var/www/
#git clone https://github.com/hvoss49/ltxonline /var/www
cd /var/www
npm install .

export NODE_ENV=production
export VERSION=$(git rev-parse HEAD)

# use forever to manage service
npm install -g forever
forever app.js
