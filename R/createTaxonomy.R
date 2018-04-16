# Description: Create taxonomy entries
# Usage: see functions below
# Author: Jerid Francom
# Date: 2018-03-01

initTaxonomy <- function(type) {
  # Function to initialize a blank taxonomy
  init <- tibble::tribble(~name, ~description, ~reference) # create structure
  taxonomy_path <- paste0("taxonomies/", type, ".csv") # create path
  readr::write_csv(init, taxonomy_path) # initialize blank taxonomy
}

enterTaxonomy <- function(name, reference, type, description = "") {
  # Function to add an entry to an existing taxonomy
  entry <- tibble::tibble(tools::toTitleCase(name), description, reference) # add data
  taxonomy_path <- paste0("taxonomies/", type, ".csv") # create path
  readr::write_csv(entry, taxonomy_path, append = TRUE) # append data
  paste0('<span class="', type, '">', tools::toTitleCase(name), '</span>') # return `name` in bubble (markdown)
}

returnTaxonomy <- function(type) {
  # Function to read, sort, format, and return a set of taxonomy entries
  library(tidyverse, quietly = TRUE)
  # Read and arrange taxonomy entries
  taxonomy_path <- paste0("taxonomies/", type, ".csv") # create path
  taxonomy <-
    readr::read_csv(file = taxonomy_path) %>%  # read entries
    arrange(name, description, reference) # arrange entries

  # Fill NAs with taxonomy description
  taxonomy <-
    taxonomy %>%
    group_by(name) %>%
    fill(description) %>% # fill (down, after sorted)
    ungroup()

  # Summarize references with ref syntax for markdown
  taxonomy <-
    taxonomy %>%
    group_by(name, description) %>%
    mutate(references = paste0("\\@ref(", sort(reference), ")", collapse = ", ")) %>%
    select(-reference) %>%
    unique %>%
    ungroup() %>%
    as.data.frame()

  # Clean up taxonomies with no descriptions
  taxonomy <-
    taxonomy %>%
    replace_na(list(description = ""))

  list <- lapply(1:nrow(taxonomy), function(i) { # format entries
    paste0("<dt>**_", tools::toTitleCase(taxonomy[i, 1]), "_**</dt>",
           "<dd>", taxonomy[i,2], " (See section(s): ", taxonomy[i, 3], ")) </dd>")
  })
  vec <- do.call(what = "c", args = list) # flatten entries
  cat("<dl>", vec, "</dl>") # wrap for display and return
}
