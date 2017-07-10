#!/bin/bash

path=`dirname $0`

grep -f $1 ${path}/470k_background_final.bed > result.bed
