make_function <- function(body,
                          arg_list,  
                          env = parent.frame()) {  
    f <- function() {}
    formals(f) <- arg_list
    body(f) <- body
    environment(f) <- env
    return(f)
}
