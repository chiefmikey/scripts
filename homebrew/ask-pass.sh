#!/bin/sh

PW_NAME="SUDO_PASS"
PW_ACCOUNT="Wolfe, Mikl"

if ! SUDO_PASS=$(security find-generic-password -w -s "${PW_NAME}" -a "${PW_ACCOUNT}"); then
  echo "error $?"
  exit 1
fi

echo "${SUDO_PASS}"
