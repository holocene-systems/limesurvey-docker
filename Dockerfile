FROM acspri/limesurvey:6.5.0

# Set up PHP with PostgreSQL PDO support.
RUN set -o errexit -o nounset -o xtrace; \
    apt-get update; \
    apt-get install --assume-yes --no-install-recommends libpq-dev; \
    docker-php-ext-install pdo_pgsql; \
    rm --recursive /var/lib/apt/lists

# AWS Fargate doesn't support persistent file bind mounts, which is why
# here we're creating an overlay volume that stores mutable data such as
# configuration files.
VOLUME /var/www/html/overlay

# Default entrypoint script assumes MySQL. Here we're replacing it with
# a far more minimal and setup-agnostic version.
COPY docker-entrypoint.sh /usr/local/bin/
