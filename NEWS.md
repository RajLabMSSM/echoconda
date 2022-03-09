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
