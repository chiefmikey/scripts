gh gist create [<filename>... | -] [flags]
Create a new GitHub gist with given contents.

Gists can be created from one or multiple files. Alternatively, pass "-" as file name to read from standard input.

By default, gists are secret; use '--public' to make publicly listed ones.

Options
-d, --desc <string>
A description for this gist
-f, --filename <string>
Provide a filename to be used when reading from standard input
-p, --public
List the gist publicly (default: secret)
-w, --web
Open the web browser with created gist





gh gist list [flags]
Options
-L, --limit <int>
Maximum number of gists to fetch
--public
Show only public gists
--secret
Show only secret gists
