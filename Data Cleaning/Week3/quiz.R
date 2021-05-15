## Question 1
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
data <- read.csv(url)

agricultureLogical <- (data$ACR == 3 & data$AGS == 6)
print(which(agricultureLogical))