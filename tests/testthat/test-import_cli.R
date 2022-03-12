test_that("import_cli works", {
    
    ## Skipping for now bc testthat causes weird issues with variable scoping
   if(FALSE){
       URL <- file.path("http://hgdownload.soe.ucsc.edu/goldenPath", 
                        "hg38/multiz100way/md5sum.txt")
       ########### curl ############
       mycurl <- import_cli(path="curl")
       #### Help ####
       out <- mycurl(h = TRUE) 
       testthat::expect_true(grepl("Usage",out[1],ignore.case = TRUE))
       #### Help ####
       ## T not working for some reason 
       out2 <- mycurl(h = T)
       testthat::expect_length(out2, 0)
       #### Download ####
       tmp <- tempfile(fileext = ".txt")
       out3 <- mycurl(url = URL,
                      o = tmp)
       tmpread <- readLines(tmp)
       testthat::expect_true(grepl("hg38",tmpread[1]))
       
       ########### wget ############
       mywget <- import_cli(path="wget")
       #### Help #### 
       out4 <- mywget(h = TRUE)
       testthat::expect_true(grepl("Wget",out4[1],ignore.case = TRUE))
       #### Download #### 
       tmp2 <- tempfile(fileext = '2.txt')
       out4 <- mywget(O = tmp2, ... = URL)
       tmpread2 <- readLines(tmp2)
       testthat::expect_true(grepl("hg38",tmpread2[1])) 
       
       ##### fastqc #####
       # myfastqc <- import_cli(path="fastqc", conda_env = "epiprepare")
       # out5 <- myfastqc(h = TRUE)
       
       ##### axel ####
       myaxel <- import_cli(path="axel", conda_env = "echoR")
       tmp3 <- tempfile(fileext = '3.txt')
       out6 <- myaxel(output.f.._o = tmp3, ... = URL)
       tmpread3 <- readLines(tmp3)
       testthat::expect_true(grepl("hg38",tmpread3[1])) 
   }
   
})
