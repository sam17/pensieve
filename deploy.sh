#!/bin/sh

USER=dementor
if [[ -z "$SOUMYADEEP_IP" ]]; then
    echo "SOUMYADEEP_IP is set to the empty string"
    exit
fi

HOST=$SOUMYADEEP_IP
DIR=/home/dementor/pensieve/

hugo && rsync -avz --delete public/ ${USER}@${HOST}:${DIR}
scp soumyadeep.in ${USER}@${HOST}:${DIR}/

exit 0
