#!/bin/bash

CONF="${HOME}/.sync-music.conf"
if [[ -f $CONF ]]; then
  source $CONF
fi

if [[ -z $SOURCE || -z $DESTINATION ]]; then
  echo "SOURCE and DESTINATION are both required and should be suitable for use by \`rsync\`.\nCheck config file (${CONF})."
  exit 1
fi

echo "Syncing from '${SOURCE}' to '${DESTINATION}'."
echo "Proceed? (y/N)"
read -n 1

if [[ $REPLY != 'y' && $REPLY != 'Y' ]]; then
  echo "Aborted by user."
  exit
fi

tmpfile=$(mktemp -t sync-music)
if [[ $? -gt 0 ]]; then
  echo "Unable to create temp file for sync output."
  exit
fi

rsync -aP --delete "${SOURCE}" "${DESTINATION}" 2>&1 | tee $tmpfile

echo
echo "Sync complete. Results saved to ${tmpfile}"

