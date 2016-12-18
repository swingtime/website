#!/bin/sh

# ---------------------------------------------------------------------
# Author:      Andy Huang (achuang@stanford.edu)
# Description: Top-level photo page creation script
# Requires:    Pictures arranged in directories by date (yyyy-mm-dd)
#              MAIN_LIST file describes all albums
# ---------------------------------------------------------------------

dir=${1:-0}

./create_slideshow2.pl $dir
