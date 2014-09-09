#!/usr/bin/env bash
tagname=$1

git add --all
git commit -m "Update commit"
git push origin master

git tag -d $tagname
git tag $tagname
git push origin :$tagname
git push origin $tagname
