# GenoPhenoEnvo Project
## *Connecting Microorganisms to Macrofloral Phenotypes and the Environment*


---

### NEON Query with R library `neonUtilities`

1. `microbe_metadata.R` in `/neon_query/` will pull metadata
  & sequence FASTQ data from NEON DAta Portal 

---

### NEON Metagenome Query through MG-RAST

**NOTE: all curl actions require an MG-RAST API key**

**NOTE 2: These data are not as up to date as those
available through the NEON R API**

1. Pulled project json sequence file metadata with: `curl -X GET -H "auth: your_mg_rast_API_key" "https://api.mg-rast.org/project/mgp13948?verbosity=full" > NEON_soil_metagenomes.json`

2. Parsed project `NEON_soil_metagenomes.json` file with Rscript `mg_json_parse.R`. This extracted the MG-RAST sample accessions in a tabular format.

3. Tabular MG-RAST sample accessions were used in a while bash loop, `sample_curl.sh`, with bash white space parsing, to `curl` download individual `*.json` files for each sample.

4. The sample `*.json` files were then cross referenced with the NEON API listing for each study site with the Rscript `neon_sample_tabulate.R`

---

### Methods

Analyses of Shotgun Metagenomes conducted with: [libra](https://github.com/iychoi/libra), [metaSPADES](https://github.com/ablab/spades), [Das TOOL](https://github.com/cmks/DAS_Tool), [anvi'o](https://github.com/merenlab/anvio), and more acknowledgements to come.
