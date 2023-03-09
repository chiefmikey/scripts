#!/bin/sh

echo "+ npm Global Upgrade"
cd "${HOME}" || exit

export STATUS=0
for package in $(npm ls -g --json | jq '.dependencies | keys' | awk -F'"' '{print $2}'); do
  # handle scoped packages
  subPackage="${package}"
  if [ -z "${subPackage##*/*}" ]; then
    subPackage="${package##*/}"
  fi

  v1="$(${subPackage} --version)"
  export v1
  # add overrides here, useful for betas etc
  # if [ "${package}" = "npm" ]; then
  #   package="npm@next-9"
  # fi

  if [ "$(npm view "${package}" version)" != "${v1}" ]; then
     npm i -gs "${package}"
     v2="$(${subPackage} --version)"
     export v2
     echo "${package} (${v1} -> ${v2})"
     export STATUS=1
  fi;
done

[ ${STATUS} -eq 0 ] && echo "Already up-to-date."
