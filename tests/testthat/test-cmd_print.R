test_that("cmd_print works", {
  
    
   out <- capture.output(
       cmd_print(c("fastqc -d ./fastqc_temp -o ${workdir}",
                   "/fastqFileQC/${sample_name} -f fastq")
                 )
   )
   testthat::expect_length(out,4)
   testthat::expect_equal(out[[1]],"fastqc")
   testthat::expect_equal(trimws(out[[2]]),"-d .../fastqc_temp")
})
