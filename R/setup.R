# Description: Boilerplate setup for each chapter
# Usage: Add to the '_bookdown.yml' `before_chapter_script:` list
# Author: Jerid Francom
# Date: 2018-12-12

# Libraries

library(knitr) # for table output
library(tidyverse) # for general workflow tools
library(EBImage) # for displaying images as figures

# Options
theme_set(theme_minimal()) # set global ggplot theme
opts_chunk$set(fig.align = 'center', # center all figures
               out.width = '75%', # limit figure widths
               fig.pos='H', # absolute positioning for PDF/LaTeX
               cache = TRUE, # cache code chunks
               warning = FALSE, # no warnings
               message = FALSE, # no messages
               error = FALSE) # no errors

