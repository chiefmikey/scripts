import sys
import subprocess

def main(args):
    if len(args) < 5:
        ssh_user = input("Enter SSH User: ")
        user_org = input("Enter User/Org: ")
        repo = input("Enter Repo: ")
        action = input("Enter Action (clone/add/set-url): ")
    else:
        _, ssh_user, user_org, repo, action = args

    # Perform the requested git action
    git_url = f"git@github.com-{ssh_user}:{user_org}/{repo}.git"
    if action == "add":
        subprocess.run(["git", "remote", "add", "origin", git_url])
    elif action == "set-url":
        subprocess.run(["git", "remote", "set-url", "origin", git_url])
    elif action == "clone":
        subprocess.run(["git", "clone", git_url])
    else:
        print(f"Unknown action: {action}")

if __name__ == "__main__":
    main(sys.argv)
