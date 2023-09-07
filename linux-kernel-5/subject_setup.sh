#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
project_name=$(echo $script_dir | rev | cut -d "/" -f 1 | rev)

dir_name=$1
current_dir=$PWD
mkdir -p $dir_name
cd $dir_name

project_url=https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
bug_commit_id=v5.0-rc8

cd $dir_name
git clone $project_url src
cd src
git checkout $bug_commit_id
