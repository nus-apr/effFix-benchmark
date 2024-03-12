"""
Auto-populate shell scripts for each bug in the benchmark.

For tool-independent scripts, we should ensure that they can be populated dynamically from the
information in meta-data.json file.

For tool-dependent scripts, the information are not supposed to be kept in meta-data.json.
Thus, those scripts should be written manually.
"""

import os
from os.path import join as pjoin
import json
from typing import List


# NOTE: this is tool dependent. Included here because of legacy reasons.
# just write template, the actual command should be manually written
def write_instrument_file_template(instrument_file):
    template = """#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
benchmark_name=$(echo $script_dir | rev | cut -d "/" -f 4 | rev)
project_name=$(echo $script_dir | rev | cut -d "/" -f 3 | rev)
bug_id=$(echo $script_dir | rev | cut -d "/" -f 2 | rev)
dir_name=$1/$benchmark_name/$project_name/$bug_id
self_dir_name=$dir_name/EffFix
mkdir $self_dir_name

config_path=$self_dir_name/repair.conf

cat > $config_path <<EOL
pulse_args=...
EOL
"""
    with open(instrument_file, "w") as f:
        f.write(template)
    os.system(f"chmod +x {instrument_file}")


def write_build_file(build_command: str, build_file):
    # note: use double {{ to escape { in f-string
    template = f"""#!/bin/bash
script_dir="$( cd "$( dirname "${{BASH_SOURCE[0]}}" )" &> /dev/null && pwd )"
benchmark_name=$(echo $script_dir | rev | cut -d "/" -f 3 | rev)
project_name=$(echo $script_dir | rev | cut -d "/" -f 2 | rev)
bug_id=$(echo $script_dir | rev | cut -d "/" -f 1 | rev)
dir_name=$1/$benchmark_name/$project_name/$bug_id
cd $dir_name/src

{build_command}
ret=$?
exit $ret
"""
    with open(build_file, "w") as f:
        f.write(template)
    os.system(f"chmod +x {build_file}")


def write_config_file(config_command, config_file):
    config_commands = config_command.split("&&")
    config_commands = [cmd.strip() for cmd in config_commands]
    template = """#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
benchmark_name=$(echo $script_dir | rev | cut -d "/" -f 3 | rev)
project_name=$(echo $script_dir | rev | cut -d "/" -f 2 | rev)
bug_id=$(echo $script_dir | rev | cut -d "/" -f 1 | rev)
dir_name=$1/$benchmark_name/$project_name/$bug_id
cd $dir_name/src
"""
    for cmd in config_commands:
        template += f"\n{cmd}"
    template += "\n"
    with open(config_file, "w") as f:
        f.write(template)
    os.system(f"chmod +x {config_file}")


def write_deps_file(deps: List[str], deps_file):
    template = "#!/bin/bash\napt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends"
    for dep in deps:
        template += " \\\n  " + dep
    template += "\n"
    with open(deps_file, "w") as f:
        f.write(template)
    os.system(f"chmod +x {deps_file}")


def write_setup_file(source_tar, setup_file):
    template = f"""#!/bin/bash
script_dir="$( cd "$( dirname "${{BASH_SOURCE[0]}}" )" &> /dev/null && pwd )"
benchmark_name=$(echo $script_dir | rev | cut -d "/" -f 3 | rev)
project_name=$(echo $script_dir | rev | cut -d "/" -f 2 | rev)
bug_id=$(echo $script_dir | rev | cut -d "/" -f 1 | rev)
dir_name=$1/$benchmark_name/$project_name/$bug_id
current_dir=$PWD
mkdir -p $dir_name
cd $dir_name

tar_name={source_tar}
download_link=https://raw.githubusercontent.com/nus-apr/efffix-benchmark/main/source/$tar_name
mkdir tmp
wget $download_link
tar -xzf $tar_name -C tmp
mv tmp/$project_name src
rm -rf tmp
"""
    with open(setup_file, "w") as f:
        f.write(template)
    os.system(f"chmod +x {setup_file}")


# linux is special, since source code is not in tar
def write_setup_file_linux(bug_commit_id, setup_file):
    template = f"""#!/bin/bash
script_dir="$( cd "$( dirname "${{BASH_SOURCE[0]}}" )" &> /dev/null && pwd )"
benchmark_name=$(echo $script_dir | rev | cut -d "/" -f 3 | rev)
project_name=$(echo $script_dir | rev | cut -d "/" -f 2 | rev)
bug_id=$(echo $script_dir | rev | cut -d "/" -f 1 | rev)
dir_name=$1/$benchmark_name/$project_name/$bug_id
current_dir=$PWD
mkdir -p $dir_name
cd $dir_name

project_url=https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
bug_commit_id={bug_commit_id}
cd $dir_name
GIT_SSL_NO_VERIFY=true git clone $project_url src
cd src
git checkout $bug_commit_id
"""
    with open(setup_file, "w") as f:
        f.write(template)
    os.system(f"chmod +x {setup_file}")

def main():
    dir_path = os.path.dirname(os.path.realpath(__file__))
    root_dir = pjoin(dir_path, "..")
    meta_file = pjoin(root_dir, "meta-data.json")

    with open(meta_file, "r") as f:
        meta_data = json.load(f)

    for entry in meta_data:
        subject = entry["subject"]
        bug_id = entry["bug_id"]
        bug_dir = pjoin(root_dir, subject, bug_id)
        if not os.path.exists(bug_dir):
            os.makedirs(bug_dir)

        # write tool independent scripts
        build_file = pjoin(bug_dir, "build.sh")
        build_command = entry.get("build_command_project", "")
        write_build_file(build_command, build_file)

        config_file = pjoin(bug_dir, "config.sh")
        config_command = entry.get("config_command", "")
        write_config_file(config_command, config_file)

        deps_file = pjoin(bug_dir, "deps.sh")
        deps = entry.get("deps", "")
        write_deps_file(deps, deps_file)

        setup_file = pjoin(bug_dir, "setup.sh")
        # for this, linux and others should be treated differently
        if subject == "linux-kernel-5":
            bug_commit_id = entry.get("bug_commit_id", "")
            write_setup_file_linux(bug_commit_id, setup_file)
        else:
            source_tar = entry.get("source_tar", "")
            write_setup_file(source_tar, setup_file)

        # write tool dependent scripts
        efffix_dir = pjoin(bug_dir, "EffFix")
        if not os.path.exists(efffix_dir):
            os.makedirs(efffix_dir)

        instrument_file = pjoin(efffix_dir, "instrument.sh")
        if not os.path.exists(instrument_file):
            write_instrument_file_template(instrument_file)


if __name__ == "__main__":
    main()
