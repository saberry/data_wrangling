#########################
### Bootstrap Example ###
#########################


rail <- read.csv("/afs/crc.nd.edu/user/s/sberry5/wrangling_test/Rail_Equipment_Accident_Incident_Data.csv")

rail$casualty <- rail$Total.Persons.Injured + rail$Total.Persons.Killed

simple_model <- lm(casualty ~ Temperature + Loaded.Freight.Cars + Minutes.Conductors.On.Duty, 
                   data = rail)

model_summary <- summary(simple_model)

t_result <- data.frame(t(model_summary$coefficients[, 't value']))

bootstraps <- 10000

output <- lapply(1:bootstraps, function(x) {
  
  sample_rows <- sample(x = 1:nrow(rail), 
                        size = 10000, 
                        replace = TRUE)
  
  sample_data <- rail[sample_rows, ]
  
  simple_model <- lm(casualty ~ Temperature + Loaded.Freight.Cars + Minutes.Conductors.On.Duty, 
                     data = sample_data)
  
  model_summary <- summary(simple_model)
  
  t_result <- data.frame(t(model_summary$coefficients[, 't value']))
  
  t_result
})

output <- do.call(rbind, output)

save(output, file = "/afs/crc.nd.edu/user/s/sberry5/wrangling_test/bootstraps.RData")