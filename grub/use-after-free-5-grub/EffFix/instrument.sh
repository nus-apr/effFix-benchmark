#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
benchmark_name=$(echo $script_dir | rev | cut -d "/" -f 4 | rev)
project_name=$(echo $script_dir | rev | cut -d "/" -f 3 | rev)
bug_id=$(echo $script_dir | rev | cut -d "/" -f 2 | rev)
dir_name=/experiment/$benchmark_name/$project_name/$bug_id
self_dir_name=$dir_name/EffFix
mkdir $self_dir_name

config_path=$self_dir_name/repair.conf

cat > $config_path <<EOL
pulse_args:--pulse-model-malloc-pattern "grub_malloc\\|grub_zalloc" --pulse-model-free-pattern "grub_free" --pulse-model-skip-pattern "grub_strcmp\\|grub_strcasecmp\\|compare_fn\\|iterate_device\\|grub_strlen\\|grub_device_open\\|grub_device_close\\|grub_partition_iterate\\|grub_device_iterate" --pulse-max-disjuncts 50 --pulse-widen-threshold 1
EOL
