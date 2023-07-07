FROM btrspg/vscode-base:latest

ADD install_packages_R.R /tmp/
ADD test.R /opt/bin/

RUN Rscript /tmp/install_packages_R.R && \
    chmod +x /opt/bin/test.R && \
    apt autoremove && \
    apt clean && \
    apt autoclean && \
    rm -rf /tmp/*