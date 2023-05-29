library(tidyverse)
library(tximport)

files <- snakemake@input[['t_data_ctab']]



names(files) <- str_split(files,pattern="/") %>%
    unlist() %>%
    matrix(ncol=3,byrow=TRUE) %>%
    as.data.frame() %>%
    pull(V2)

print(files)

txi.trans<-tximport(files,type = "stringtie",txOut = TRUE)
#print(txi.trans$counts %>% head())
#print(txi.trans$length[,1])

tmp <- read_tsv(files[1])
#tmp %>% head() %>% DT::datatable()
tx2gene <- tmp[, c("t_name", "gene_id")]
tx2gene
txi.genes <- tximport(files, type = "stringtie", tx2gene = tx2gene)

txi.genes$counts %>% as.data.frame() %>% 
  mutate(geneLength=txi.genes$length[,1]) %>% 
  round() %>% 
  rownames_to_column("gene_name") %>% 
  write_csv(snakemake@output[['gene_counts']])


txi.trans$counts %>% 
  as.data.frame() %>% 
  mutate(geneLength=txi.trans$length[,1]) %>% 
  round() %>% 
  rownames_to_column("trans_id") %>% 
  write_csv(snakemake@output[['trans_counts']])