# SnakemakeIntroduction



https://snakemake.readthedocs.io/en/stable/ snakemake的官方文档

### 以有参转录组数据处理为例介绍snakemake的基本用法

首先介绍一个转录组的背景知识

随着测序技术的发展和测序成本的下降，常规的转录组测序已经成为了一个非常普遍的技术手段，做转录组最常见的一个目的就是看在某个特定的条件下哪些基因是差异表达的，那么这些差异的基因就有可能和这个特定的条件有关系，这个差异是通过数字算出来的，比如geneA在对照中的表达是2 3 2 在处理中是 10 11 10 ，那我们就可以通过一定的统计检验来判断这俩个基因的表达量是否有差异。 但实际的转录组测序测出来的都是ATCG这种碱基，我们需要通过一定的流程把 这些碱基转换成每个基因对应的表达量的数字，以有参转录组为例，

- 对参考基因组构建索引

- 然后对原始的测序数据做一个过滤，去除一些测序质量不好的数据

- 把测序数据比对到参考基因组上 获得一个sam格式的文件

- 把sam格式转换为bam格式

- 利用每个bam文件去算每个基因的表达量


构建索引只需要做一次，但是接下来的四部每个样本都要重复一次，如果是三个对照三个处理的一组实验，每个样本都要做同样的四个步骤，这个时候自然出现一个需求 能不能把这些步骤整合起来，我只需要一步就能够从原始的测序数据直接到基因表达量文件

能够满足这个需求的工具有很多，最常用的可能是直接写shell脚本，还有很多其他的流程整合工具

https://github.com/pditommaso/awesome-pipeline

https://academic.oup.com/bib/article/18/3/530/2562749?login=false

A review of bioinformatic pipeline frameworks

生物信息相关的比较常用的有nextflow 还有就是这个snakemake

什么是snakemake


https://github.com/marbl/verkko

https://www.nature.com/articles/s41587-023-01662-6  Telomere-to-telomere assembly of diploid chromosomes with Verkko

https://github.com/mrvollger/StainedGlass StainedGlass: Interactive visualization of massive tandem repeat structures with identity heatmaps


我比较喜欢用snakemake，主要原因是


- snakemake非常好安装

- python写的工具，可以直接搭配python的代码


https://github.com/darencard/2019-snakemake-Harvard-Informatics-nanocourse/blob/master/tutorial.md


### 配置环境

```
conda create -n rnaseq
conda activate rnaseq
conda install snakemake
conda install fastp
conda install hisat2
conda install samtools
conda install stringtie
conda install r
conda install r-tidyverse
conda install bioconductor-tximport
```

### 运行代码

```
snakemake -s rnaseq.smk --configfile=config.yaml --cores 8 -p
```

如果要运行自己的数据，只需要修改config.yaml文件里的文件路径即可

如果是在集群上提交任务

```
#!/bin/bash


#SBATCH --job-name="rnaseq"
#SBATCH -n 4 #threads
#SBATCH -N 1 #node number
#SBATCH --mem=4000
#SBATCH --partition=cuPartition
#SBATCH --mail-user=mingyan24@126.com
#SBATCH --mail-type=BEGIN,END,FAIL

source activate rnaseq
snakemake --cluster "sbatch --output=/abc/00.slurm.out/%j.out \
--error=/abc/00.slurm.out/%j.out --cpus-per-task={threads} \
--mail-type=END,FAIL --mail-user=mingyan24@126.com --partition=cuPartition --mem={resources.mem_mb}" \
--jobs 20 -s rnaseq.smk -p -k
```

