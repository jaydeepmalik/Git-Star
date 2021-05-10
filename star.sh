#!/bin/bash
printf "+==========+ Git Star - Mass Git Starred Link Grabber +==========+\n"
printf "+---------- By Jaydeep Malik (http://jaydeepmalik.com) ----------+\n"
printf "\n \n"
printf "Enter Git Username:"
read user_name
printf "\n \n"
USER=${1:-$user_name}
STARS=$(curl -sI https://api.github.com/users/$USER/starred?per_page=1|egrep '^Link'|egrep -o 'page=[0-9]+'|tail -1|cut -c6-)
PAGES=$((1000/100+1))
echo You have $STARS starred repositories.
echo
for PAGE in `seq $PAGES`; do
    curl -sH "Accept: application/vnd.github.v3.star+json" "https://api.github.com/users/$USER/starred?per_page=100&page=$PAGE"|jq -r '.[]|[.repo.full_name]|@tsv'
done >> star.txt

echo "Task Completed :)"