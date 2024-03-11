#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
benchmark_name=$(echo $script_dir | rev | cut -d "/" -f 3 | rev)
project_name=$(echo $script_dir | rev | cut -d "/" -f 2 | rev)
bug_id=$(echo $script_dir | rev | cut -d "/" -f 1 | rev)
dir_name=/experiment/$benchmark_name/$project_name/$bug_id
current_dir=$PWD
mkdir -p $dir_name
cd $dir_name
mkdir dev-patch

project_url=https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
bug_commit_id=v5.0-rc8
cd $dir_name
GIT_SSL_NO_VERIFY=true git clone $project_url src
cd src
git checkout $bug_commit_id

if [ -d "/data/$project_name/pre" ]
then
    cp -rf /data/$project_name/pre $dir_name
fi
