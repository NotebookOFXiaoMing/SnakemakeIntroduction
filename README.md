# SnakemakeIntroduction

https://academic.oup.com/bib/article/18/3/530/2562749?login=false

A review of bioinformatic pipeline frameworks

https://snakemake.readthedocs.io/en/stable/ snakemake的官方文档

### 以有参转录组数据处理为例介绍snakemake的基本用法

首先介绍一个转录组的背景知识

随着测序技术的发展和测序成本的下降，常规的转录组测序已经成为了一个非常普遍的技术手段，做转录组最常见的一个目的就是看在某个特定的条件下哪些基因是差异表达的，那么这些差异的基因就有可能和这个特定的条件有关系，这个差异是通过数字算出来的，比如geneA在对照中的表达是2 3 2 在处理中是 10 11 10 ，那我们就可以通过一定的统计检验来判断这俩个基因的表达量是否有差异。 但实际的转录组测序测出来的都是ATCG这种碱基，我们需要通过一定的流程把 这些碱基转换成每个基因对应的表达量的数字


什么是snakemake


https://github.com/marbl/verkko

https://www.nature.com/articles/s41587-023-01662-6  Telomere-to-telomere assembly of diploid chromosomes with Verkko

https://github.com/mrvollger/StainedGlass StainedGlass: Interactive visualization of massive tandem repeat structures with identity heatmaps


