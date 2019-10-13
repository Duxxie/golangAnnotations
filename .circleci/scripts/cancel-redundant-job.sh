#!/usr/bin/env bash

# CircleCI implements the same functionality, except that it doesn't cancel the default branch (development in our case)

mkdir ~/.ssh/
ssh-keyscan github.com > ~/.ssh/known_hosts
git fetch

LATEST_SHA=$(git log -n 1 origin/"$CIRCLE_BRANCH" --pretty=format:"%H")

if [ "$LATEST_SHA" != "$CIRCLE_SHA1" ]; then
    CANCEL_URL="https://circleci.com/api/v1.1/project/github/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/$CIRCLE_BUILD_NUM/cancel?circle-token=$CIRCLE_API_TOKEN"
    echo -e "\033[0;31mERROR: Build cancelled."
    echo -e "There are new commits on this branch. Latest commit: $LATEST_SHA\033[0m"
#    echo -e "Executing the following command: curl -X POST ${CANCEL_URL}"
    curl -X POST "${CANCEL_URL}"
    sleep 30
fi
