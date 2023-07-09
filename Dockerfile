FROM btrspg/vscode-base:latest

ADD install_packages_R.R /tmp/
ADD packages.bash /opt/bin/

RUN Rscript /tmp/install_packages_R.R \
    && chmod +x /opt/bin/packages.bash \
    && /opt/bin/packages.bash



RUN apt autoremove && \
    apt clean && \
    apt autoclean && \
    rm -rf /tmp/*