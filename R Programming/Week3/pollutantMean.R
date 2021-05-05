pollutantmean <- function(directory, pollutant, id=1:332) {
  main_dir = 'D:/Archel/Coursera/John Hopkins Data Science/R Programming/Week3/'
  files <- list.files(path=paste(main_dir, directory, sep=''))[id]
  
  read_files <- lapply(paste(main_dir, directory, '/', files, sep=''), read.csv)
  
  data <- do.call(rbind, read_files)
  
  mean(data[, pollutant], na.rm=TRUE)
}

