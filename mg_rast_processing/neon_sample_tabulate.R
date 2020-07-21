#!/usr/bin/env Rscript

library(jsonlite)
library(tidyverse)
library(googlesheets4)

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

# -----------------------------------------------------------

# import from google sheets directly with my API authentication
neon_sites <- read_sheet("https://docs.google.com/spreadsheets/d/1RFBirlPtoZJzdIoYTTOemO2olg3u85VQyCfu-Hspdas/edit?usp=sharing")

# site codes for grep or group_by
targets <- neon_sites$`Sites with 3+ Metagenome Sequences`

# -----------------------------------------------------------
# counts by site from the metagenome JSON API
# -----------------------------------------------------------

# extract side codes to match gsheets 
json_sites <- gsub( "_.*", "", meta_df$name)

# make a dataframe of counts for each site
json_counts <- as.data.frame(as.matrix(table(json_sites)))

# make row names into a column
json_counts <- rownames_to_column(json_counts, "sites")

# rename second colname

names(json_counts)[2] <- "json_api_counts"


names(neon_sites)[1] <- "sites"

names(neon_sites)[2] <- "neon_api_counts" 

count_comparison <- left_join(neon_sites[, 1:2], json_counts, by = "sites")

neonurl <- "https://docs.google.com/spreadsheets/d/13iqnppyx7m8yoZAxRmr0wDpNyDq_NQglXTaTmXMDFRc/edit?usp=sharing"

sheet_write(data = count_comparison, ss = neonurl, sheet = "Sheet1")
