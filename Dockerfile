# Dockerfile
FROM shanesveller/phoenix-framework:latest

ENV MIX_ENV=prod PORT=80

COPY . /usr/src/app
RUN mix deps.get --only prod && \
    mix compile && \
    node_modules/brunch/bin/brunch build --production && \
    mix phoenix.digest

# Set timezone to Pacific
RUN ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime

EXPOSE 80
CMD ["mix","phoenix.server"]
