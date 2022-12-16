input variables to delete secret
check repo if secret exists
have option to list repo secrets and choose which one to delete aka interactive

gh secret delete
gh secret delete <secret-name> [flags]
Delete a secret on one of the following levels:

repository (default): available to Actions runs or Dependabot in a repository
environment: available to Actions runs for a deployment environment in a repository
organization: available to Actions runs or Dependabot within an organization
user: available to Codespaces for your user
Options
-a, --app <string>
Delete a secret for a specific application: {actions|codespaces|dependabot}
-e, --env <string>
Delete a secret for an environment
-o, --org <string>
Delete a secret for an organization
-u, --user
Delete a secret for your user
Options inherited from parent commands
-R, --repo <[HOST/]OWNER/REPO>
Select another repository using the [HOST/]OWNER/REPO format