# change here is you want to pin R version
FROM rocker/r-base:latest

# change maintainer here
LABEL maintainer="Man Chen <manchen9005@gmail.com>"

# add system dependencies for packages as needed
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    && rm -rf /var/lib/apt/lists/*

# we need remotes and renv
RUN install2.r --error remotes BH R6 Rcpp base64enc commonmark crayon digest fastmap glue htmltools httpuv intrval jsonlite later magrittr mime promises rlang shiny sourcetools withr xtable

# EXPOSE can be used for local testing, not supported in Heroku's container runtime
EXPOSE 8080

# web process/code should get the $PORT environment variable
ENV PORT=8080

# command we want to run
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port=as.numeric(Sys.getenv('PORT')))"]
