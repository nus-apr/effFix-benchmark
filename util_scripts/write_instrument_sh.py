"""
Auto-populate instrument.sh files.
"""

import os
from os.path import join as pjoin
import json


def write_instrument_file(pulse_args, instrument_file):
    # note: use double {{ to escape { in f-string
    template = f"""#!/bin/bash
script_dir="$( cd "$( dirname "${{BASH_SOURCE[0]}}" )" &> /dev/null && pwd )"
benchmark_name=$(echo $script_dir | rev | cut -d "/" -f 4 | rev)
project_name=$(echo $script_dir | rev | cut -d "/" -f 3 | rev)
bug_id=$(echo $script_dir | rev | cut -d "/" -f 2 | rev)
dir_name=/experiment/$benchmark_name/$project_name/$bug_id
self_dir_name=$dir_name/EffFix
mkdir $self_dir_name

config_path=$self_dir_name/repair.conf

cat > $config_path <<EOL
pulse_args={pulse_args}
EOL
"""
    with open(instrument_file, "w") as f:
        f.write(template)
    os.system(f"chmod +x {instrument_file}")


def main():
    dir_path = os.path.dirname(os.path.realpath(__file__))
    root_dir = pjoin(dir_path, "..")
    meta_file = pjoin(root_dir, "meta-data.json")

    with open(meta_file, "r") as f:
        meta_data = json.load(f)

    for entry in meta_data:
        subject = entry["subject"]
        bug_id = entry["bug_id"]
        efffix_dir = pjoin(root_dir, subject, bug_id, "EffFix")
        if not os.path.exists(efffix_dir):
            os.makedirs(efffix_dir)

        pulse_args = entry.get("pulse_args", "")
        if not pulse_args:
            continue
        instrument_file = pjoin(efffix_dir, "instrument.sh")
        write_instrument_file(pulse_args, instrument_file)


if __name__ == "__main__":
    main()
