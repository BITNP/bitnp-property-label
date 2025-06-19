#!/bin/bash

COUNT=""
while [[ $# -gt 0 ]]; do
  case $1 in
    -c|--count)
      COUNT="$2"
      shift 2
      ;;
    *)
      echo "Unknown option $1"
      echo "Usage: $0 [-c|--count <number>]"
      exit 1
      ;;
  esac
done

if [[ -z "$COUNT" ]]; then
  read -p "Enter the number of IDs to generate: " COUNT
fi

if ! [[ "$COUNT" =~ ^[0-9]+$ ]] || [[ "$COUNT" -le 0 ]]; then
  echo "Error: Please provide a valid positive integer for the count."
  exit 1
fi

for i in $(seq 1 $COUNT); do
  HASH=$(echo -n $(date +%s%3N) | sha1sum | awk '{print substr($1,1,8)}' | tr 'a-z' 'A-Z');
  DATE=$(date +%y%m)
  echo "$DATE-$HASH"
done > ./ids.txt
