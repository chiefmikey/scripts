#!/bin/sh

# deletes from remote? not sure

git remote update origin --prune

FORMAT="%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)"

for branch in $(git branch --list --format ${FORMAT}); do
echo $branch
  #[ "${branch}" != "" ] && git push origin --delete ${branch}
done

# other option

git branch --no-contains master --merged master | xargs git branch -d