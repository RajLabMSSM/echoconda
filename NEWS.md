# echoconda 0.99.9

## New features

* Implemented `rworkflows`.

# echoconda 0.99.8

## Bug fixes 

* `yaml_to_env`:
    - `search_yamls` returns yaml path,
    - Check that env exists earlier.
* Add `echodata` to Imports. 
* Fix GHA: @master --> @v2  
* Add R packages back into "echoR_mini" for PolyFun.

# echoconda 0.99.7

## New features

* Add and export new functions:
    - `get_os`
    - `find_executables_remote`

## Bug fixes

* `set_permissions`: Remove and use `echodata` implementation instead
    (to avoid namespace conflicts). 
* `find_executables_remote`: Avoid printing when `verbose=FALSE`.

# echoconda 0.99.6

## New features

* New functions:
    - `remove_env`
    - `create_env`
    - `find_conda`
    - `list_envs` 
* `find_packages`:
    - Benchmarked multiple methods for speed and completeness 
    of recovering excecutable paths.
* Setup `basilisk`
* *echoR_mini*:
    - Bare minimum conda env that solves in 2.5min.
    - Replaces *echoR* as the default. 
* Install conda via `basilisk` by default. 

## Bug fixes

* Fix GHA pkgdown building: 
    - The newest version of [git introduced bugs when building pkgdown sites](https://github.com/actions/checkout/issues/760) from within Docker containers (e.g. via my Linux GHA workflow). Adjusting GHA to fix this. 
* Add `R.utils` to Imports. 

# echoconda 0.99.5

## New features

* New functions:
    - `cmd_print`
    - `set_permissions`
* New conda env yaml:
    - *epiprocess.yml*  

# echoconda 0.99.4

## New features

* Update GitHub Actions. 
* `find_packages`: New function to search for packages across all conda envs.
* `env_to_yaml`: New function to export yaml file.
* `yaml_to_env`: New function to create env from yaml file. 
* `list_yamls`: New function to list available yaml files shipped with
`echoconda`. 
* Add minimal *test.yml* and *test_bad.yml* files. 

## Bug fixes 

* Try to allow switching between envs again. 
* Omit setting env vars in *zzz.R*. 
* Provide *echoR_windows.yaml* that omits conda packages 
not available on Windows OS.

# echoconda 0.99.0

* Added a `NEWS.md` file to track changes to the package.
