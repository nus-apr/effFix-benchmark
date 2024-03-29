# effFix Benchmark

C Programs with memory-errors detected by Infer (Pulse)

##  Data Set

| Subject        |# Leak| # NPE | # DF | # UAF | # Total |
|----------------|---|---|---|---|---|
| swoole         | 3 | - | - | - | 3 |
| p11-kit        | 1 | - | 2 | 1 | 4 |
| x264           | 6 | - | - | - | 6 |
| snort          | 8 | - | - | - | 8 |
| openssl-1      | 4 | 5 | - | - | 9 |
| openssl-3      | - | 3 | - | - | 3 |
| linux-kernel-5 | 2 | 1 | - | - | 3 |
| grub           | - | - | 2 | 7 | 9 |
| lxc            | - | - | - | 2 | 2 |
| Total          |24 | 9 | 4 |10 |47 |

- Leak: memory leak
- NPE: null pointer dereference
- DF: double free
- UAF: use after free

## Contributors
* Yuntong Zhang
* Ridwan Shariffdeen


## Remarks on keys in meta-data file

- compile_programs:
    - used by FootPatch during repair.
    - used by SAVER in its preparation phase.
    - used by EffFix during repair stage, when compiling one file is sufficient.
- source, sink: used by SAVER to populate its config file.
- build_command: used by EffFix pre stage to analyze the entire project.
- pulse_args: extra command line arguments required for Pulse to detect the bug.


- old_bug_id_in_saver: only for UAF/DF bugs. Maps to the original bug id in the SAVER benchmark.


## Updated meta-data key definition

- build_command_project: Overall build command used for building the project. Mainly used in EffFix pre stage for whole program analysis
- build_command_repair: Build command for the specific module/object that is relevant for the repair. Currently used by all tools.
    For smaller projects, this can be the same as build_command_project.

- bug_commit_id: Only for linux. Used in setting up project source code. Linux is not packged in tar
    due to its size.


## Notes on building some of the benchmark programs.

- For openssl-1, using parallel build (e.g. `make -j32`) can cause undefined symbol errors.
This is because earlier versions of openssl do not support parallel build.
See: https://github.com/openssl/openssl/issues/5762
