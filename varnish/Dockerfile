FROM varnish:6.0.5

RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends  \
	    supervisor \
	    less   \
	    vim    \
	    procps \
	    curl   \
	    wget;  \
	rm -rf /var/lib/apt/lists/*
