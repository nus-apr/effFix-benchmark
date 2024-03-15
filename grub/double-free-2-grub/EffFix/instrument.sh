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
pulse_args:--headers --pulse-model-malloc-pattern "grub_malloc\\\|grub_zalloc" --pulse-model-free-pattern "grub_free" --pulse-model-skip-pattern "grub_file_read\\\|grub_memcpy\\\|grub_be_to_cpu16\\\|grub_be_to_cpu32\\\|grub_crypto_lookup_md_by_name\\\|grub_file_tell\\\|calculate_uncompressed_size\\\|grub_file_seek\\\|read_block_reader" --pulse-max-disjuncts 50
EOL
