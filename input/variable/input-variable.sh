#!/bin/sh

while [ -z "${}" ]; do
  echo "${}: (${})"
  read "${}"
done

echo "${}"
