# effFix Benchmark
C Programs with memory-errors detected by Infer (Pulse)

# Data Set
| Subject        |# Bugs|
|----------------|------|
| linux-kernel-5 |3     |
| openssl-1      |9     |
| openssl-3      |4     |
| p11-kit        |1     |
| snort          |7     |
| swoole         |3     |
| WavPack        |0     |
| x264           |6     |
| Total          |33    |


# Contributors
* Yuntong Zhang
* Ridwan Shariffdeen



## Remarks on keys in meta-data file

- compile_programs:
    - used by FootPatch during repair.
    - used by SAVER in its preparation phase.
- source, sink: used by SAVER to populate its config file.
