FROM opencpu/base

RUN apt-get -y update && \
    apt-get -y install \
        nginx \
        libfontconfig1-dev \
        libcairo2-dev \
        libcurl4-openssl-dev \
        pandoc \
        apt-utils \
        libtiff5-dev \
        libfribidi-dev \
        libharfbuzz-dev

RUN R -e 'install.packages(c("devtools", "R.utils"), repo = "https://cran.rstudio.com/")'

RUN R -e 'install.packages("BiocManager"); BiocManager::install()'
RUN R -e 'BiocManager::install(c("ggplot2", "GEOquery", "genefilter","htmltools", \
        "httpuv", "jsonlite", "limma", "edgeR", "assertthat", "methods", "httr", "rhdf5", \
        "utils", "parallel", "stringr", "fgsea", "svglite", "gtable", "stats", \
        "Matrix", "Matrix.utils", "pheatmap", "scales", "ccaPP", "grid", "grDevices", \
        "AnnotationDbi", "apeglm", "DESeq2", "Rook"))' && \
    R -e 'remove.packages("BH")'
        
RUN R -e 'BiocManager::install(c("testthat", "BiocStyle", "knitr", "rmarkdown", "data.table"))'

RUN \
  cd ~ && \
  apt-get install -y --no-install-recommends \
    gosu
