FROM python:3.12-slim
RUN useradd -ms /bin/bash user

RUN apt-get update \
  && apt-get install --no-install-recommends --yes  plantuml graphviz imagemagick make \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ADD requirements.txt .
RUN python3 -m pip install --no-cache-dir --upgrade pip -r requirements.txt

WORKDIR /docs
USER user

CMD ["sphinx-build", "-M", "html", ".", "_build"]
