FROM python:3.12-slim
RUN useradd -ms /bin/bash user

RUN apt-get update \
  && apt-get install --no-install-recommends --yes \
    plantuml \
    graphviz \
    imagemagick \
    make \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir --upgrade pip
RUN python3 -m pip install --no-cache-dir \
  sphinx==7.1.2 \
  pillow==10.2.0 \
  sphinxcontrib-plantuml==0.27 \
  docutils==0.20.1 \
  sphinx-rtd-theme==2.0.0

WORKDIR /docs
USER user

CMD ["sphinx-build", "-M", "html", ".", "_build"]
