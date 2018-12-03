# script for retreiving Custom Fields and adding them to the df dataframe
# this is the generic version for GitHub
# this script requires the trelloR package
# merge_custfields assumes that cust_fields only has the 5 columns listed in the README

# Updated version of get_card_fields from trelloR
get_card_custfields <- function (id, ...) { 
  dat = get_model(parent = "card", id = id, child = "customFieldItems", ...)
}

##############################################

rownames(df) <- df[,1]    # changes the row names of df to the id names
merge_custfields <- for (x in df$id) {
  cust_fields <- get_card_custfields(x, token = my_token)   # retreives the custom fields 
  g <- 1                                # important for the correct value.text observation to be extracted
  for (y in cust_fields$idCustomField) {
    if(y %in% colnames(df)) {           # if the idCustomField is a column in df
    df[x,y] <- cust_fields[g,5]         # extract the observation at [g,5] and puts it into the current row and column of df
    # print(c("yes", y, g))             # used for testing purposes
    g <- g+1                            # important for the next correct value.text observation to be extracted
    }
    else {                              # if the idCustomField is NOT a column in df
      df$newcolumn <- NA                # creates a new column in df
      names(df)[names(df) == 'newcolumn'] <- y    # changes the name of that column to the current idCustomField
      df[x,y] <- cust_fields[g,5]               
      # print(c("no", y, g))            # used for testing purposes
      g <- g+1                          
    }
  }
}

colnames(df) <- c("id", "name", "Title", "Company", "Email Address", "Twitter", "LinkedIn") 
# This is seperate from merge_custfields because you might not know the desired custom field names until after looking at the resulting dataframe
# These column names are from the example in the README