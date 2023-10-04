library(doParallel)
library(foreach)
library(parallel)
library(stringr)

rail <- read.csv("/afs/crc.nd.edu/user/s/sberry5/wrangling_test/Rail_Equipment_Accident_Incident_Data.csv")

# for(i in colnames(rail)) {
#   
#   if(any(str_detect(rail[, i], "[0-9]"))) {
#     rail[, i] <- gsub("[^0-9]", "", rail[, i])
#     
#     rail[, i] <- as.numeric(rail[, i])
#   }
# }

cluster <- parallel::makeCluster(12)

doParallel::registerDoParallel(cluster)

output <- foreach(i = colnames(rail), 
        .packages = c("stringr")) %dopar%
  if(any(str_detect(rail[, i], "[0-9]"))) {
    var_sub <- gsub("[^0-9]", "", rail[, i])
    
    var_sub <- as.numeric(var_sub)
    
    var_sub
  }

parallel::stopCluster(cluster)

registerDoSEQ()

save(output, file = "/afs/crc.nd.edu/user/s/sberry5/wrangling_test/output.RData")