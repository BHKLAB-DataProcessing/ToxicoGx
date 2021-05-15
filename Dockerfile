FROM registry.codeocean.com/codeocean/r-base:4.0.0-ubuntu18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN Rscript -e 'remotes::install_github( \
        "bhklab/CoreGx", \
        ref = "febf598cb579333e8bc1f1c5fdad6ac30b709416")' \
    && Rscript -e 'remotes::install_github( \
        "bhklab/ToxicoGx", \
        ref = "5cc8641e454ef33c93aabf5ab4ad226f9a9280f3")'

RUN Rscript -e 'install.packages("BiocManager")'
RUN Rscript -e 'BiocManager::install(c( \
        "SummarizedExperiment", \
        "abind", \
        "affy", \
        "affyio", \
        "biomaRt", \
        "car", \
        "dplyr", \
        "gdata", \
        "ggplot2", \
        "readxl", \
        "xml2", \
        "magicaxis" \
    ))'

RUN Rscript -e "install.packages('devtools')"
RUN Rscript -e "install.packages('biocompute')"
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 51716619E084DAB9
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN wget 'https://filesforpublic.blob.core.windows.net/toxicogx/hgu133plus2hsensgcdf_24.0.0.tar.gz'
RUN wget 'https://filesforpublic.blob.core.windows.net/toxicogx/rat2302rnensgcdf_24.0.0.tar.gz'
RUN wget 'https://bioc.ism.ac.jp/packages/3.11/bioc/src/contrib/Archive/PharmacoGx/PharmacoGx_2.0.1.tar.gz'
RUN wget 'https://cran.r-project.org/src/contrib/Archive/data.table/data.table_1.12.8.tar.gz'

RUN Rscript -e "library(devtools); install.packages('hgu133plus2hsensgcdf_24.0.0.tar.gz', repos = NULL, type = 'source')"
RUN Rscript -e "library(devtools); install.packages('rat2302rnensgcdf_24.0.0.tar.gz', repos = NULL, type = 'source')"
RUN Rscript -e "library(devtools); install.packages('PharmacoGx_2.0.1.tar.gz', repos = NULL, type = 'source')"
RUN Rscript -e "library(devtools); install.packages('data.table_1.12.8.tar.gz', repos = NULL, type = 'source')"
