#!/usr/bin/env bash
tagname=$1

if [ -z $tagname ]
then
  echo "请输入 \"tag name\" "
  exit 0
fi

echo "Tag $tagname"

git add --all
git commit -m "Update commit"
git push origin master

git tag -d $tagname
git tag $tagname
git push origin :$tagname
git push origin $tagname
