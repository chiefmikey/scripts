#!/bin/bash

while [ -z "${}" ]; do
  echo "${}: (${})"
  read "${}"
done

echo "${}"
