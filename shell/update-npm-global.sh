#!/bin/zsh

echo "+ npm global update"
for package in $(npm ls -g --json | jq '.dependencies | keys' | awk -F'"' '{print $2}'); do
  export v1=$(${package} --version)
  if [ $(npm view ${package} version) != ${v1} ]; then
     npm i -gq ${package}
     export v2=$(${package} --version)
     echo "${package} (${v1} -> ${v2})"
  else
    echo "${package} (${v1})"
  fi;
done
