#!/bin/sh

PW_NAME="SUDO_PASS"
PW_ACCOUNT="Wolfe, Mikl"

if ! SUDO_PASS=$(security find-generic-password -w -s "${PW_NAME}" -a "${PW_ACCOUNT}"); then
  echo "Error: ${?}"
  # test to see what the cant find password error string is
  if [ "${?##*something*}"]; then
    echo "No password: ${PW_NAME} found for user: ${PW_ACCOUNT}"
    echo "Password:"
    read SUDO_PASS

    while \
    [ "${CONFIRM}" != "y" ] && \
    [ "${CONFIRM}" != "yes" ] && \
    [ "${CONFIRM}" != "n" ] && \
    [ "${CONFIRM}" != "no" ]; do
      echo "Title: ${PW_NAME}"
      echo "Username: ${PW_ACCOUNT}"
      echo "Password: ${SUDO_PASS//?/*}"
      echo "Confirm: (y/n)"
      read CONFIRM
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
