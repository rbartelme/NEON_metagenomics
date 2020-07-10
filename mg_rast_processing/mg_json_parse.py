#!/usr/bin/env python3

import json
import pandas as pd

#load json file
with open("NEON_soil_metagenomes.json") as f:
    neon_data = json.load(f)

#list keys in dictionary
print(list(neon_data))

# Keys in neon_json
# ['metagenomes', 'pi', 'permissions', 'ratings', 'url', 'name', 'description',
# 'libraries', 'id', 'metadata', 'status', 'version', 'created',
# 'funding_source', 'samples']

#print(neon_data)
#print(type(neon_data))

#convert json to pandas df
#neon_df = pd.DataFrame.from_dict(neon_data)

#write out neon_df as a tsv
#neon_df.to_csv("neon_soil_metagenomes.tsv", sep="\t", index=False)
