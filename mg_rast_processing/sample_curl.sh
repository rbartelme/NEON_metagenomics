#!/usr/bin/env bash

# this takes tsv output from mg_json_parse.R
# use read in shell built-in to parse the tsv
while IFS=$'\t' read -r value1 value2 remainder
do
    curl -X GET -H \
    "auth: your_mg_rast_API_key" \
    "${value2}" \
    >> ${value1}.json
done < "test_input.txt"
