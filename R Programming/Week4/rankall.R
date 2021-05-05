rankall <- function(outcome, num = "best") {
  ## Read outcome data
  df <- read.csv('./R Programming/Week4/outcome-of-care-measures.csv', colClasses='character')
  temp <- as.data.frame(cbind(df[, 2],
                              df[, 7],
                              df[, 11],
                              df[, 17],
                              df[, 23]),
                        stringsAsFactors=FALSE)
  colnames(temp) <- c('hospital', 'state', 'heart attack', 'heart failure', 'pneumonia')
  temp[, eval(outcome)] <- as.numeric(temp[, eval(outcome)])
  
  ## Check that state and outcome are valid
  if(!outcome %in% c('heart attack', 'heart failure', 'pneumonia')) {
    stop('invalid outcome')
  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name 
  } else if(is.numeric(num)) {
    state_idx <- with(temp, split(temp, state))
    rank <- list()
    for(i in seq_along(state_idx)) {
      state_idx[[i]] <- state_idx[[i]][order(state_idx[[i]][, eval(outcome)],
                                             state_idx[[i]][, 'hospital']), ]
      rank[[i]] <- c(state_idx[[i]][num, 'hospital'], state_idx[[i]][, 'state'][1])
    }
    ans <- do.call(rbind, rank)
    final_ans <- as.data.frame(ans, row.names=ans[, 2], stringsAsFactors=FALSE)
    names(final_ans) <- c('hospital', 'state')
    
  } else if(!is.numeric(num)) {
    if(num == 'best') {
      state_idx <- with(temp, split(temp, state))
      rank <- list()
      for(i in seq_along(state_idx)) {
        state_idx[[i]] <- state_idx[[i]][order(state_idx[[i]][, eval(outcome)],
                                               state_idx[[i]][, 'hospital']), ]
        rank[[i]] <- c(state_idx[[i]][1, c('hospital', 'state')])
      }
      ans <- do.call(rbind, rank)
      final_ans <- as.data.frame(ans, stringsAsFactors=FALSE)
      rownames(final_ans) <- final_ans[, 2]
    } else if(num == 'worst') {
      state_idx <- with(temp, split(temp, state))
      rank <- list()
      for(i in seq_along(state_idx)) {
        state_idx[[i]] <- state_idx[[i]][order(state_idx[[i]][, eval(outcome)],
                                               state_idx[[i]][, 'hospital'], decreasing=TRUE), ]
        rank[[i]] <- c(state_idx[[i]][1, c('hospital', 'state')])
      }
      ans <- do.call(rbind, rank)
      final_ans <- as.data.frame(ans, stringsAsFactors=FALSE)
      rownames(final_ans) <- final_ans[, 2]
    } else {
      final_ans <- NA
    }
  }
  return(final_ans)
}
