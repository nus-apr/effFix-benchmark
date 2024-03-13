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
pulse_args:--pulse-model-malloc-pattern "grub_malloc\\|grub_zalloc" --pulse-model-free-pattern "grub_free"  --pulse-model-skip-pattern "grub_strlen\\|grub_isdigit\\|grub_strtoul\\|grub_strncmp\\|grub_error\\|grub_make_scsi_id\\|grub_dprintf\\|grub_scsi_inquiry\\|grub_get_time_ms\\|grub_scsi_test_unit_ready\\|grub_scsi_read_capacity10\\|grub_scsi_read_capacity16"  --pulse-max-disjuncts 2000 --pulse-widen-threshold 1
EOL
