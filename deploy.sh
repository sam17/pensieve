#!/bin/sh

USER=dementor
HOST=azkaban.in
DIR=/var/www/write.soumyadeep.in

hugo && rsync -avz --delete public/ ${USER}@${HOST}:${DIR}

exit 0
