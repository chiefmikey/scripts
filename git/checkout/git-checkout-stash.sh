#!/bin/sh

while
[ "${STASH_IT}" != "y" ] &&
[ "${STASH_IT}" != "yes" ] &&
[ "${STASH_IT}" != "n" ] &&
[ "${STASH_IT}" != "no" ]; do
  echo "Stash changes: (y/n)"
  read STASH_IT
done

if [ "$STASH_IT" = "y" ] || [ "$STASH_IT" = "yes" ] ; then
  git stash push --all --message "checkout"
  git checkout "${@:1}"
fi

#!/bin/sh

while
[ "${POP_IT}" != "y" ] &&
[ "${POP_IT}" != "yes" ] &&
[ "${POP_IT}" != "n" ] &&
[ "${POP_IT}" != "no" ]; do
  echo "Pop stash on new branch: (y/n)"
  read POP_IT
done

if [ "$POP_IT" = "y" ] || [ "$POP_IT" = "yes" ] ; then
  STASH=$(git stash list | awk -F':' '{ print $1":"$3 }' | grep "checkout" | awk -F':' '{ print $1 }')
  echo $STASH
  git stash pop ${STASH}
fi
