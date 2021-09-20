test_that("env_from_yaml works", {
    
    #### Default: local echoR yaml ####
    conda_env1 <- env_from_yaml()
    testthat::expect_equal(
        conda_env1,
        if (env_exists("echoR")) "echoR" else "base"
    )
    
    #### remote echoR yaml ####
    capture.output(message("some messsge"))
    conda_env2 <- env_from_yaml(
        yaml_path = file.path("https://github.com/RajLabMSSM/echoconda",
                              "raw/main/inst/conda/echoR.yml"))
    testthat::expect_true(
        # May or may not create the conda env 
        # due to slow internet.
        conda_env2 %in% c("echoR","base")
    )
    
    #### Typo #####
    conda_env3 <- env_from_yaml(yaml_path = "typo")
    testthat::expect_equal(conda_env3,"base")
})
