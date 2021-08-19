#!/usr/bin/env bash

BUILD_DIR=$1
ENV_DIR=$2
START_DIR=$( pwd )

cd "$ENV_DIR"
for e in GIT_TOKEN GIT_ORG GIT_REPO HEROKU_BRANCH ; do
  export "${e}=$( cat $e )"
done

cd "$BUILD_DIR"
git clone https://${GIT_TOKEN}@github.com/${GIT_ORG}/${GIT_REPO}
cd sierra
git checkout "$HEROKU_BRANCH" || echo "$HEROKU_BRANCH branch not found in SDK repo - keeping it at 'next'"
./heroku/shuffle-folders.sh

cd "$START_DIR"
