#!/bin/bash

PW_NAME="SUDO_PASS"
if [ "$(whoami)" = "mwolfe" ]; then
  PW_ACCOUNT="Wolfe, Mikl"
else
  PW_ACCOUNT="Wolfe, Mikl"
fi

if ! SUDO_PASS=$(security find-generic-password -w -s "${PW_NAME}" -a "${PW_ACCOUNT}"); then
  echo "Error: ${?}"
  # test to see what the cant find password error string is
  if [ "${?##*something*}" ]; then
    echo "No password: ${PW_NAME} found for user: ${PW_ACCOUNT}"
    echo "Password:"
    read -r SUDO_PASS

    while \
    [ "${CONFIRM}" != "y" ] && \
    [ "${CONFIRM}" != "yes" ] && \
    [ "${CONFIRM}" != "n" ] && \
    [ "${CONFIRM}" != "no" ]; do
      echo "Title: ${PW_NAME}"
      echo "Username: ${PW_ACCOUNT}"
      echo "Password: ${SUDO_PASS//?/*}"
      echo "Confirm: (y/n)"
      read -r CONFIRM
    done

    if [ "${CONFIRM}" = "y" ] || [ "${CONFIRM}" = "yes" ]; then
      security add-generic-password -s "${PW_NAME}" -a "${PW_ACCOUNT}" -w "${SUDO_PASS}"
    else
      echo "Operation cancelled"
      exit 1
    fi
  fi
fi

echo "${SUDO_PASS}"
