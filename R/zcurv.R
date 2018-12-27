
# Z Curve -----------------------------------------------------------------

zcurve = function(string = NULL, n = NULL){
    strs = stringr::str_split(string, pattern = "")
    nInterval = n - 2
    nTotal = n + nInterval
    
    res = list()
    
    j = 1
    for(s in strs){
        nc = (n-1) * (length(s) %/% nTotal) + (length(s) %% nTotal %/% n) + 1
        df = matrix(data = "", nrow = n, ncol = nc)
        for (i in 1:length(s)){
            rx = ifelse((i %% nTotal <= n) & (i %% nTotal > 0), i %% nTotal,  
                        ifelse(i %% nTotal == 0, 2, n - (i %% nTotal) %% n ))
            ry = ifelse((i %% nTotal <= n) & (i %% nTotal > 0), 
                        (n-1) * (i %/% nTotal) + 1, 
                        ifelse((i %% nTotal <= n) & (i %% nTotal == 0),
                               (n-1) * (i %/% nTotal),
                               (n-1) * (i %/% nTotal) + i %% nTotal %% n + 1)
                            )
                        
            df[rx, ry] = s[i]
        }
        res[[j]] = df
        j = j + 1
    }

    if(length(res) == 1){
        prmatrix(res[[1]], 
                 rowlab=rep("",nrow(res[[1]])), 
                 collab=rep("",ncol(res[[1]])),
                 quote = FALSE)
    }else{
        for(i in 1:length(res)){
            cat("#---- Z Curve #", i, "\n")
            cat("\n")
            prmatrix(res[[i]], 
                     rowlab=rep("",nrow(res[[i]])), 
                     collab=rep("",ncol(res[[i]])),
                     quote = FALSE)
            cat("\n")
        }
    }

}

zcurve(string = paste0(letters[1:20], collapse = ""), n = 5)
zcurve(string = c(paste0(letters[1:20], collapse = ""),
                  paste0(letters[20:1], collapse = "")), n = 5)

zcurve(string = paste0(letters[1:20], collapse = ""), n = 2)
zcurve(string = paste0(letters[1:20], collapse = ""), n = 3)
zcurve(string = paste0(letters[1:20], collapse = ""), n = 4)

zcurve(string = paste0(rep(c("5","2","0","Z","h","o","u","D","a","n"),10),collapse = ""),
       n = 6)
