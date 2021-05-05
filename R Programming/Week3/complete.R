complete <- function(directory, id=1:332) {
  main_dir = 'D:/Archel/Coursera/John Hopkins Data Science/R Programming/Week3/'
  files <- list.files(path=paste(main_dir, directory, sep=''), full.names=TRUE)
  
  data <- data.frame()
  
  for(i in id) {
    csv <- read.csv(files[i])
    print(complete.cases(csv))
    nobs <- sum(complete.cases(csv))
    d <- data.frame(i, nobs)
    data <- rbind(data, d)
  }
  
  colnames(data) <- c('id', 'nobs')
  print(data)
}

