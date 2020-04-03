#!/bin/bash

echo "Creating log folder"
mkdir -p $INSTALL_PATH/log

if [ "$RAILS_ENV" = "production" ]; then
  # Verify all the production gems are installed
  bundle check
else
  # install any missing development gems (as we can tweak the development container without rebuilding it)
  bundle check || bundle install --without production
fi

yarn install --check-files

## Run any pending migrations
bundle exec rails db:migrate

echo "--------- Starting Whiskey App in $RAILS_ENV mode ---------"
rm -f /tmp/whiskey_app.pid
cd $INSTALL_PATH && bundle exec rails server -p 3000 -b '0.0.0.0' --pid /tmp/whiskey_app.pid
