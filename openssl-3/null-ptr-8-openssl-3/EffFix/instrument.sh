#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
benchmark_name=$(echo $script_dir | rev | cut -d "/" -f 4 | rev)
project_name=$(echo $script_dir | rev | cut -d "/" -f 3 | rev)
bug_id=$(echo $script_dir | rev | cut -d "/" -f 2 | rev)
dir_name=$1/$benchmark_name/$project_name/$bug_id
self_dir_name=$dir_name/EffFix
mkdir -p $self_dir_name

config_path=$self_dir_name/repair.conf

cat > $config_path <<EOL
pulse_args:--pulse-max-disjuncts 50 --pulse-model-malloc-pattern CRYPTO_malloc --pulse-model-free-pattern CRYPTO_free --pulse-model-realloc-pattern CRYPTO_realloc --pulse-skip-procedures 'test_single_eval\|openssl_add_all_*'
EOL
