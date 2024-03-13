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
pulse_args:--pulse-model-skip-pattern "do_lxcapi_*\\|lxc_list_init\\|lxc_caps_init\\|lxc_arguments_parse\\|lxc_log_init\\|lxc_container_new\\|set_argv\\|lxc_config_define_load\\|set_config_item\\|lxc_setup_shared_ns" --pulse-model-free-pattern "lxc_container_put" --pulse-max-disjuncts 100 --pulse-widen-threshold 1
EOL
