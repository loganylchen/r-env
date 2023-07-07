FROM btrspg/vscode-base:latest

ADD install_packages_R.R /tmp/

RUN Rscript /tmp/install_packages_R.R  \



RUN apt autoremove && \
    apt clean && \
    apt autoclean && \
    rm -rf /tmp/*