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
pulse_args:--pulse-model-skip-pattern "p11_tool_getopt\\|p11_kit_be_loud\\|atoi\\|getgrnam\\|p11_message\\|getpwnam\\|p11_tool_usage\\|p11_message_err\\|setgid\\|setgroups\\|setuid\\|asprintf\\|getpid\\|secure_getenv\\|p11_path_build\\|mkdir\\|server_new\\|server_loop\\|" --pulse-max-disjuncts 50 --pulse-widen-threshold 1
EOL
