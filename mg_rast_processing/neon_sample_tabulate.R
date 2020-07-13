#!/usr/bin/env Rscript

library(jsonlite)
library(tidyverse)

# read in all json files in the directory as a list

meta_samples <- list.files(path = "~/NEON_metagenomics/mg_rast_processing/sample_json/",
           pattern = "*.json", full.names = TRUE)

# purr map to read all JSON into filesystem
meta_json <- purrr::map(meta_samples, read_json)

# unlist JSON files inside list
meta_un <- purrr::map(meta_json, unlist)

#convert list of unlisted JSON file to data frame with dplyr
meta_df <- bind_rows(lapply(meta_un, as.data.frame.list))

# gsub: all periods in column names with underscores
names(meta_df) <- gsub("\\.", "_", names(meta_df))

# gsub: replace all column names ending in 1 to nothing
names(meta_df) <- gsub("1", "", names(meta_df))

# gsub: all column names ending in 2, repalce with _url
names(meta_df) <- gsub("2", "_url", names(meta_df))



