rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  df <- read.csv('./R Programming/Week4/outcome-of-care-measures.csv', colClasses='character')
  temp <- as.data.frame(cbind(df[, 2],
                              df[, 7],
                              df[, 11],
                              df[, 17],
                              df[, 23]),
                        stringsAsFactors=FALSE)
  colnames(temp) <- c('hospital', 'state', 'heart attack', 'heart failure', 'pneumonia')
  #print(temp)
  ## Check that state and outcome are valid
  if(!state %in% temp[, 'state']) {
    stop('invalid state')
  } else if(!outcome %in% c('heart attack', 'heart failure', 'pneumonia')) {
    stop('invalid outcome')
  } else if(is.numeric(num)) {
    state_idx <- which(temp[, 'state'] == state)
    df_state <- temp[state_idx,]
    df_state[, eval(outcome)] <- as.numeric(df_state[, eval(outcome)])
    df_state <- df_state[order(df_state[, eval(outcome)], df_state[, 'hospital']), ]
    ans <- df_state[, 'hospital'][num]
  } else if(!is.numeric(num)) {
    if(num == 'best') {
      ans <- best(state, outcome)
    } else if(num == 'worst') {
      state_idx <- which(temp[, 'state'] == state)
      df_state <- temp[state_idx, ]
      df_state[, eval(outcome)] <- as.numeric(df_state[, eval(outcome)])
      df_state <- df_state[order(df_state[, eval(outcome)], df_state[, 'hospital'], decreasing=TRUE), ]
      ans <- df_state[, 'hospital'][1]
    } else {
      ans <- NA
    }
  }
  return(ans)
}
