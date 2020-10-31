#!/bin/bash
#
# reads from stdin to p
#
#
set -xe

PATTERN_NAME=${1:-email}

PATTERN=$(cat registry.tsv\
 | grep "${PATTERN_NAME}"\
 | cut -f2)

preston ls\
 | preston match -l tsv "${PATTERN}"\
 | grep "http://www.w3.org/ns/prov#value"\
 | cut -f1,3\
 | sed 's+^.*hash:+hash:+g'\
 | sed 's+!/.*\t+\t+g'\
 | uniq\
 | awk -F '\t' '{ print $2 $1 "|" $2 "\t" $1 }'
