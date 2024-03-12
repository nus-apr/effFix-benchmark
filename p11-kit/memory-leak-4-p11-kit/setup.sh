#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
benchmark_name=$(echo $script_dir | rev | cut -d "/" -f 3 | rev)
project_name=$(echo $script_dir | rev | cut -d "/" -f 2 | rev)
bug_id=$(echo $script_dir | rev | cut -d "/" -f 1 | rev)
dir_name=$1/$benchmark_name/$project_name/$bug_id
current_dir=$PWD
mkdir -p $dir_name
cd $dir_name

tar_name=p11-kit-instrumented.tar.gz
download_link=https://raw.githubusercontent.com/nus-apr/efffix-benchmark/main/source/$tar_name
mkdir tmp
wget $download_link
tar -xzf $tar_name -C tmp
mv tmp/$project_name src
rm -rf tmp
