#!/bin/sh
git filter-branch --env-filter '
OLD_EMAIL="jinzhao@nsea.com.cn"
CORRECT_NAME="paopaol"
CORRECT_EMAIL="467847281@qq.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' -f  --tag-name-filter cat -- --branches --tags
