FROM busybox
MAINTAINER Luigi Pirelli<lpirelli@boundlessgeo.com>

# create postgres user and groups for the data container
# guid and uid are set the same for the kartooza/postgis container
RUN addgroup -g 111 postgres \
    && adduser -H -D -G postgres -u 106 postgres

# create the volume path where to store configuration
RUN mkdir -p /var/lib/postgresql/9.4/main

# populate dbdata
ADD ./pgdata /var/lib/postgresql/9.4/main

# cheange permission to all copied files
RUN chown -R postgres:postgres /var/lib/postgresql
RUN chmod -R go-rwx /var/lib/postgresql/9.4/main

# specify the volume to export 
# I'm not sure it's necessary because I've always to set -v in the data-container
VOLUME /var/lib/postgresql/9.4/main

# set running user. hopefully sould set the user when mounting 
# /var/lib/postgresql/9.4/main as volume from other containers
USER postgres
