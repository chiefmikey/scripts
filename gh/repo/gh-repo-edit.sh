BRANCH="main"

# Set default branch
gh repo edit ${REPO}--default-branch ${BRANCH}

# Set auto-merge
gh repo edit [<repository>] --enable-auto-merge
