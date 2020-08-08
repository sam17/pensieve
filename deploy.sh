#!/bin/sh

USER=dementor
HOST=azkaban.in
DIR=/home/dementor/pensieve/

hugo && rsync -avz --delete public/ ${USER}@${HOST}:${DIR}
scp soumyadeep.in ${USER}@${HOST}:${DIR}/

exit 0
