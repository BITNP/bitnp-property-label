#!/bin/bash

# Start Configuration
SINGLE_MODE_PAGE_CONTAINS=112
DOUBLE_MODE_PAGE_CONTAINS=42
# End Configuration

function get_help {
  echo "Usage: $0 [-c|--count <number>] [--page <number>] [--single|--double]"
  echo "Options:"
  echo "  -c, --count <number>   Specify the number of IDs to generate."
  echo "  --page <number>        Specify the page number for ID generation."
  echo "  --single               Generate IDs for single-sided pages."
  echo "  --double               Generate IDs for double-sided pages."
}

COUNT=""
MODE=""
while [[ $# -gt 0 ]]; do
  case $1 in
    -c|--count)
      COUNT="$2"
      shift 2
      ;;
    -p|--page)
      PAGE="$2"
      shift 2
      ;;
    --single)
      MODE="single"
      shift
      ;;
    --double)
      MODE="double"
      shift
      ;;
    -h|--help)
      get_help
      exit 0
      ;;
    *)
      echo "Unknown option $1"
      get_help
      exit 1
      ;;
  esac
done

if [[ -z "$MODE" ]]; then
  MODE="single"
fi

if [[ ! -z "$PAGE" ]]; then
  if [[ "$MODE" == "single" ]]; then
    COUNT=$(($PAGE * $SINGLE_MODE_PAGE_CONTAINS))
  elif [[ "$MODE" == "double" ]]; then
    COUNT=$(($PAGE * $DOUBLE_MODE_PAGE_CONTAINS))
  else
    echo "Error: Invalid page mode. Use 'single' or 'double'."
    exit 1
  fi
fi

if ! [[ "$COUNT" =~ ^[0-9]+$ ]] || [[ "$COUNT" -le 0 ]]; then
  echo "Error: Please provide a valid positive integer for the count."
  get_help
  exit 1
fi

./idgen.sh -c "$COUNT"

if [[ "$MODE" == "single" ]]; then
  typst compile single-side.typ generated.pdf
elif [[ "$MODE" == "double" ]]; then
  typst compile double-side.typ generated.pdf
fi