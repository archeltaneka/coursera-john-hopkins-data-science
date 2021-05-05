corr <- function(directory, threshold=0) {
  main_dir = 'D:/Archel/Coursera/John Hopkins Data Science/R Programming/Week3/'
  files <- list.files(path=paste(main_dir, directory, sep=''), full.names=TRUE)
  
  data <- vector(mode='numeric', length=0)
  
  for(i in 1:length(files)) {
    csv <- read.csv(files[i])
    col_sum <- sum((!is.na(csv$sulfate)) & (!is.na(csv$nitrate)))
    
    if(col_sum > threshold) {
      temp <- csv[which(!is.na(csv$sulfate)), ]
      temp2 <- temp[which(!is.na(temp$nitrate)), ]
      data <- c(data, cor(temp2$sulfate, temp2$nitrate))
    }
  }
  data
}

