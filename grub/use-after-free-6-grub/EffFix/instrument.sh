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
pulse_args:--headers --pulse-model-malloc-pattern "grub_malloc\\\|grub_zalloc" --pulse-model-free-pattern "grub_free\\\|grub_crypto_cipher_close" --pulse-model-skip-pattern "grub_disk_read\\\|grub_memcpy\\\|grub_be_to_cpu16\\\|grub_strcasecmp\\\|grub_dprintf\\\|grub_crypto_lookup_cipher_by_name\\\|grub_to_be_cpu32\\\|grub_strcmp\\\|grub_crypto_lookup_md_by_name\\\|grub_disk_get_size\\\|grub_error" --pulse-max-disjuncts 1000 --pulse-widen-threshold 1
EOL
