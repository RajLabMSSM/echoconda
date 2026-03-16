# Parse options

Parse the available options (arguments) for a given command line tool.

## Usage

``` r
parse_options(
  path,
  command = NA,
  subcommand = NA,
  help_args = c("-h", "--help", "-help", "-H"),
  args_sep = "\n",
  args_start = "-+[a-z]+",
  col_names = c("arg", "description"),
  verbose = TRUE
)
```

## Arguments

- path:

  Path to executable file.

- command:

  Modifying command for tool (e.g. "submodule" when running "git
  submodule add").

- subcommand:

  Modifying subcommand for tool (e.g. "add" when running "git submodule
  add").

- help_args:

  Help arguments to use when identifying argument options.

- args_sep:

  Regex pattern that separates each new argument.

- args_start:

  Regex pattern to search for when detecting the beginning of each
  argument description.

- col_names:

  Column names after parsing.

- verbose:

  Print messages.

## Examples

``` r
if (FALSE) { # \dontrun{
opts <- echoconda::parse_options(path="curl")
} # }
```
