#!/bin/sh

echo "+ GH Repo Create"

repo_create () {
  [ "${REMOTE}" = "origin" ] && gh repo create ${DIR_NAME} --source=. --public --push
  [ "${REMOTE}" != "origin" ] && gh repo create ${DIR_NAME} --source=. --public --push --remote=${REMOTE}
}

HAS_REMOTE=$(git remote -v)
if [ -z "${HAS_REMOTE}" ]; then
  repo_create
else
  git remote remove ${REMOTE}
  repo_create
fi


# use 'gh repo view' to check if repo already exists
# check std output for success
# check error output for failure
