# Description: Create glossary entries
# Usage: see functions below
# Author: Jerid Francom
# Date: 2018-02-20

# WORKING ON EXPORTING THESE FUNCTION TO `INDEXR`

initGlossary <- function(glossary = "main") {
  # Function to initialize a blank glossary
  dir.create(path = "./glossaries/", showWarnings = FALSE) # create directory
  glossary_path <- paste0("glossaries/", glossary, ".csv") # create path
  init <- tibble::tribble(~term, ~definition, ~reference) # create structure
  readr::write_csv(init, glossary_path) # initialize blank glossary

  if(!file.exists("980-glossaries.Rmd")) cat(file = "980-glossaries.Rmd", paste0('# Glossary {-} \n\n```{r, results=\'asis\', echo=FALSE}\nreturnGlossary(glossary = "', glossary, '")\n```\n\n')) # Create Rmd file
}

enterGlossary <- function(term, definition, reference, glossary = "main") {
  # Function to add an entry to an existing glossary
  entry <- tibble::tibble(term, definition, reference) # add data
  glossary_path <- paste0("glossaries/", glossary, ".csv") # create path
  readr::write_csv(entry, glossary_path, append = TRUE) # append data
  paste0("**_", term, "_**") # return `term` in bold (markdown)
}

returnGlossary <- function(glossary = "main") {
  # Function to read, sort, format, and return a set of glossary entries
  glossary_path <- paste0("glossaries/", glossary, ".csv") # create path
  glossary <- readr::read_csv(file = glossary_path) # read entries
  glossary <- as.data.frame(dplyr::arrange(glossary, term)) # sort entries
  list <- lapply(1:nrow(glossary), function(i) { # format entries
    paste0("<dt>**_", tools::toTitleCase(glossary[i, 1]), "_**</dt>",
           "<dd>", glossary[i, 2], " (See section \\@ref(", glossary[i, 3], ")) </dd>")
  })
  vec <- do.call(what = "c", args = list) # flatten entries
  cat("<dl>", vec, "</dl>") # wrap for display and return
}
