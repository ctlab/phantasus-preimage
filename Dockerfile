FROM debian:10


RUN \
  apt-get update && \
  apt-get install -y gpg && \
  apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' && \
  echo "deb http://cloud.r-project.org/bin/linux/debian buster-cran35/" > /etc/apt/sources.list.d/cran.list && \
  apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get -y install \
      --no-install-recommends \
      nginx \
      libfontconfig1-dev \
      libcairo2-dev \
      wget \
      apache2 \
      libapreq2-dev \
      r-base \
      r-base-dev \
      r-cran-xml \
      libapparmor-dev \
      libcurl4-openssl-dev \
      libprotobuf-dev \
      protobuf-compiler \
      libcairo2-dev \
      curl \
      libssl-dev \
      libxml2-dev \
      libicu-dev \
      pkg-config \
      libssh2-1-dev \
      locales \
      apt-utils 

RUN \
  cd ~ && \
  wget --quiet https://archive.opencpu.org/debian-10/opencpu-lib_2.1.6-buster0_amd64.deb && \
  wget --quiet https://archive.opencpu.org/debian-10/opencpu-server_2.1.6-buster0_all.deb

RUN \
  cd ~ && \
  apt-get install -y \
    --no-install-recommends \
    libapache2-mod-r-base \
    ssl-cert \
    && \
  dpkg -i opencpu-lib_*.deb && \
  dpkg -i opencpu-server_*.deb


  

RUN R -e 'install.packages("devtools", repo = "https://cran.rstudio.com/")'

RUN R -e 'install.packages("BiocManager"); BiocManager::install()'

RUN R -e 'BiocManager::install(c("ggplot2", "GEOquery", "htmltools", \
        "httpuv", "jsonlite", "limma", "assertthat", "methods", "httr", "rhdf5", \
        "utils", "parallel", "stringr", "fgsea", "svglite", "gtable", "stats", \
        "Matrix", "Matrix.utils", "pheatmap", "scales", "ccaPP", "grid", "grDevices", \
        "AnnotationDbi", "DESeq2", "Rook"))' && \
    R -e 'remove.packages("BH")'

RUN R -e 'BiocManager::install(c("testthat", "BiocStyle", "knitr", "rmarkdown", "data.table"))' && \
    R -e 'remove.packages("BH")'


RUN \
  cd ~ && \
  apt-get install -y --no-install-recommends \
    gosu
