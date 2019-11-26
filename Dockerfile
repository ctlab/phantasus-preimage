FROM opencpu/ubuntu-18.04

RUN R -e 'install.packages("devtools", repo = "https://cran.rstudio.com/")'

RUN R -e 'install.packages("BiocManager"); BiocManager::install()'

RUN R -e 'BiocManager::install(c("ggplot2", "GEOquery", "htmltools", \
        "httpuv", "jsonlite", "limma", "assertthat", "methods", "httr", "rhdf5", \
        "utils", "parallel", "stringr", "fgsea", "svglite", "gtable", "stats", \
        "Matrix", "Matrix.utils", "pheatmap", "scales", "ccaPP", "grid", "grDevices", \
        "AnnotationDbi", "DESeq2"))'

RUN apt-get -y update && \
    apt-get -y install \
        nginx \
        libfontconfig1-dev \
        libcairo2-dev

RUN R -e 'BiocManager::install(c("testthat", "BiocStyle", "knitr", "rmarkdown", "data.table"))'

RUN R -e 'BiocManager::install(c("Rook"))
