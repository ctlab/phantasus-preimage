FROM opencpu:ubuntu-18.04

RUN R -e 'install.packages("devtools", repo = "https://cran.rstudio.com/")'

RUN R -e 'install.packages("BiocManager"); BiocManager::install()'
