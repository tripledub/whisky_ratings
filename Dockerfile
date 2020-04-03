FROM ruby:2.7.0

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - nodejs: Compile assets
# - libpq-dev: Communicate with postgres through the postgres gem
# - postgresql-client-9.4: In case you want to talk directly to postgres
RUN apt-get update && apt-get install -qq -y build-essential nodejs npm libpq-dev postgresql-client-11 --fix-missing --no-install-recommends


# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY Gemfile* /tmp/
WORKDIR /tmp

RUN gem install bundler -v 2.1.4

RUN bundle install

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /whiskey_app
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

ADD . $INSTALL_PATH

RUN npm install npm@latest -g
RUN npm install yarn -g

# Expose a volume so that nginx will be able to read in assets in production.
VOLUME ["$INSTALL_PATH/public"]

COPY ./docker-entrypoint.sh /bin/

CMD ["/bin/docker-entrypoint.sh"]
