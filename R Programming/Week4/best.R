best <- function(state, outcome) {
  ## Read outcome data
  df <- read.csv('./R Programming/Week4/outcome-of-care-measures.csv', colClasses='character')
  
  ## Check that state and outcome are valid
  if(!any(state == df$State)) {
    stop('invalid state')
  } else if((outcome %in% c('heart attack', 'heart failure', 'pneumonia')) == FALSE) {
    stop('invalid outcome')
  }
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  df_state <- subset(df, State==state)
  if (outcome == 'heart attack') idx = 11
  else if(outcome == 'heart failure') idx = 17
  else idx = 23
  
  observation <- which(as.numeric(df_state[, idx]) == min(as.numeric(df_state[, idx]), na.rm=TRUE))
  ans <- df_state[observation, 2]
  ans <- sort(ans)
  
  return(ans[1])
}
