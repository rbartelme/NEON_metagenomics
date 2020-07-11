#!/usr/bin/env bash

# use read in shell built-in to parse the tsv
while IFS=" " read -r value1 value2 remainder
do
    curl -X GET -H \
    "auth: your_mg_rast_API_key" \
    $value1 \
    > ${value2}.json
done < "test_input.txt" > "test_out.txt"
