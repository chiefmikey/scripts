input variables to set secret
use list command to see if secret already exists
if it exists then delete it (confirm) and then create it to basically update it



gh secret set <secret-name> [flags]

# Repository is current directory
gh secret set SNYK_TOKEN --app actions --body "$SNYK_TOKEN"

Set a value for a secret on one of the following levels:

repository (default): available to Actions runs or Dependabot in a repository
environment: available to Actions runs for a deployment environment in a repository
organization: available to Actions runs or Dependabot within an organization
user: available to Codespaces for your user
Organization and user secrets can optionally be restricted to only be available to specific repositories.

Secret values are locally encrypted before being sent to GitHub.

-a, --app <string>
Set the application for a secret: {actions|codespaces|dependabot}

-b, --body <string>
The value for the secret (reads from standard input if not specified)

-e, --env <environment>
Set deployment environment secret

-f, --env-file <file>
Load secret names and values from a dotenv-formatted file

--no-store
Print the encrypted, base64-encoded value instead of storing it on Github

-o, --org <organization>
Set organization secret

-r, --repos <repositories>
List of repositories that can access an organization or user secret

-u, --user
Set a secret for your user

-v, --visibility <string>
Set visibility for an organization secret: {all|private|selected}




gh secret list [flags]
List secrets on one of the following levels:

repository (default): available to Actions runs or Dependabot in a repository
environment: available to Actions runs for a deployment environment in a repository
organization: available to Actions runs or Dependabot within an organization
user: available to Codespaces for your user
Options
-a, --app <string>
List secrets for a specific application: {actions|codespaces|dependabot}
-e, --env <string>
List secrets for an environment
-o, --org <string>
List secrets for an organization
-u, --user
List a secret for your user
Options inherited from parent commands
-R, --repo <[HOST/]OWNER/REPO>
Select another repository using the [HOST/]OWNER/REPO format
