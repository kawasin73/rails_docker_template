#!/usr/bin/env sh
#
# release script
#

set -eu

#
# remove files for release
#
rm script/release.sh
rm .circleci/config.yml

#
# parse ruby version
#
RUBY_VERSION=$(cat Gemfile | grep ruby | grep -v "source" | sed "s/.*'\([0-9]\(\.[0-9]*\)*\)'.*/\1/g")

#
# parse rails version
#
RAILS_VERSION=$(cat Gemfile | grep rails | sed "s/.*'\([0-9]\(\.[0-9]*\)*\)'.*/\1/g")

#
# check git current branch
#
BRANCH=$(git rev-parse --abbrev-ref HEAD)
SUFFIX=
if [ $BRANCH = master ]; then
    SUFFIX=""
elif [ $BRANCH = webpacker ]; then
    SUFFIX="-webpack"
else
    echo "$BRANCH is not branch for release"
    exit 1
fi

#
# create release branch name
#
RELEASE_BRANCH="ruby-$RUBY_VERSION-rails-$RAILS_VERSION$SUFFIX"
BASE_BRANCH="base/$RELEASE_BRANCH"

echo
echo === branch name ===
echo RELEASE_BRANCH = $RELEASE_BRANCH
echo BASE_BRANCH = $BASE_BRANCH
echo

#
# setup git config
#
git config user.email "kawasin73@gmail.com"
git config user.name "Kawamura Shintaro"

#
# create .circleci/config.yml
#
echo
echo === create .circleci/config.yml ===
echo

cat .circleci/config.yml.sample | sed "s/{{RUBY_VERSION}}/$RUBY_VERSION/g" > .circleci/config.yml
rm .circleci/config.yml.sample

#
# remove duplicated branch
#
if [ -n "$(git branch | grep $BASE_BRANCH)"  ]; then
    echo === remove git branch $BASE_BRANCH ===
    git branch -D $BASE_BRANCH
else
    echo === not found git branch $BASE_BRANCH ===
fi

if [ -n "$(git branch | grep $RELEASE_BRANCH)"  ]; then
    echo === remove git branch $RELEASE_BRANCH ===
    git branch -D $RELEASE_BRANCH
else
    echo === not found git branch $RELEASE_BRANCH ===
fi

#
# create base branch
#
echo
echo === create base branch ===
echo

git checkout -b $BASE_BRANCH

# create initial commit
git reset `git rev-list --max-parents=0 --abbrev-commit HEAD`
git add .
git commit --amend --no-edit --author="Kawamura Shintaro <kawasin73@gmail.com>" --date="`date -R`"

#
# build template and create release branch
#
echo
echo === build template and create release branch ===
echo

git checkout -b $RELEASE_BRANCH

echo
echo === script/init ===
echo
sudo script/init

echo
echo === script/bootstrap ===
echo
sudo script/bootstrap

echo
echo === remove config/credentials.yml.enc config/master.key ===
echo
sudo rm config/credentials.yml.enc config/master.key

# create build commit
git add .
git commit -m "script/init && script/bootstrap && rm config/credentials.yml.enc config/master.key"

#
# git push created branches
#
echo
echo === git push created branches ===
echo

git push -f -u origin $BASE_BRANCH
git push -f -u origin $RELEASE_BRANCH

#
# clean up
#
echo
echo === clean up ===
echo
docker-compose down -v

sudo rm -rf log/ tmp/
