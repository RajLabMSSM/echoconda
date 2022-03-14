make_function_body <- function(new_path,
                               fix_names){
    body <- quote({
        arg_list2 <- as.list(match.call(definition = func))[-1]
        ### Map back to original argument names 
        if(fix_names){ 
            # print(arg_list2)
            message("Mapping argument names to original version.")
            names(arg_list2) <- unname(arg_map[names(arg_list2)]) 
            # print(arg_list2)
        } 
        # if("intern" %in% names(arg_list2)){
        #     ## Check for special intern variable and then remove from list
        #     intern <- arg_list2[["intern"]]
        #     if(is.null(intern)) intern <- FALSE 
        #     arg_list2[["intern"]] <- NULL
        # }
        arg_strings <- lapply(names(arg_list2), function(nm){
            # message("Getting: ",nm)
            x <- eval(arg_list2[[nm]])
            if(nm=="..."){
                return(x)
            } else if(all(is.null(x)) || all(x=="")) {
                return("")
            } else if (any(x==TRUE)) {
                return(paste(nm," "))
            } else {
                return(paste(nm,x," "))
            }
        }) 
        cmd <- paste(new_path,  
                     paste(arg_strings, collapse = "")
        )
        cmd_print(cmd = cmd)
        sys_out <- system(cmd, intern = TRUE ) 
        message("Output:")
        cat(paste(sys_out,collapse = '\n'))
        return(sys_out)
    })
    return(body)
} 
