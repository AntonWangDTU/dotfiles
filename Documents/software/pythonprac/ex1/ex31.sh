#!/usr/bin/zsh

dir=$1

if [[ $dir == '' ]]; then
  dir=$(pwd)
fi

total=0
# Loop safely through files in the directory
for file in "$dir"/*; do
  if [[ -f $file ]]; then
    number=$(wc -l $file | cut -d ' ' -f1)
    echo $number
  fi
done
