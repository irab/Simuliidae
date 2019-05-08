#!/bin/bash
# 1. project variant (directory)
# 2. compose file additions
export VSITE_COMPOSE_PROJECT_VARIANT=$1
shift
BASE="base"
GENNAME=""
CONFIGS=""
# iterate
while test ${#} -gt 0
do
  ADD=$1
  if [[ -z $GENNAME ]]; then
    GENNAME=${ADD}
  else
    GENNAME=${GENNAME}-${ADD}
  fi
  CONFIGS="$CONFIGS -f $ADD.yml"
  shift
done
docker-compose -f ${VSITE_COMPOSE_PROJECT_VARIANT}/${BASE}.yml $CONFIGS config | sed 's/{VSITE/\${VSITE/g' | sed "s/ \([^[:space:]]*\): ''$/ - \1/" > ${VSITE_COMPOSE_PROJECT_VARIANT}/${GENNAME}.yml
