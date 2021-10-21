#!/bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cp $scriptdir/sum.ipynb ./
cp $scriptdir/../hw/sum/recordbatch.rb ./
python -m notebook ./sum.ipynb
