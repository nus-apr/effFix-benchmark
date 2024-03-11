#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
project_name=$(echo $script_dir | rev | cut -d "/" -f 1 | rev)
dir_name=$1
current_dir=$PWD
mkdir -p $dir_name
cd $dir_name

download_link=https://raw.githubusercontent.com/nus-apr/efffix-benchmark/main/source/$project_name-instrumented.tar.gz

mkdir tmp
wget $download_link
tar -xzf $project_name.tar.gz -C tmp
mv tmp/$project_name src
rm -rf tmp
