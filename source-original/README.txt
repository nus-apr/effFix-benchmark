Contains the original, uninstrumented project source codes for reference.

- For openssl projects, the source code here are the original version from the project.
- For other projects, the source code here are from SAVER artifact.
    - These may already contain instrumentations by the SAVER authors to fix build issues.
    - SAVER artifact address: https://github.com/yuntongzhang/saver-artifact


Organization:

For each source code project, there are
- A tar that contains the orignal source code. E.g. `double-free-1-grub.tar.gz`. This was created by `tar -czvf` the original directory.
- A diff file showing the instrumentation introduced on top of the tar version. E.g. `double-free-1-grub.instrument.diff`.
    - If there is no corresponding diff file, the subject does not have any intrumentation.


Steps in preparing the benchmark programs:

1. Get the original source code.
2. Commit it with git.
3. Create the original tar with `tar -cvzf ...`, and save it in this directory.
4. If no instrumentation is needed, copy the same tar to `archive` as the final experiment tar.
4. If instrumentation is needed,
    1. Apply the instrumentation
    2. Create a diff file, with `git diff` and save it in this directory.
    3. Commit the instrumentation.
    4. Create an instrumented tar and save it in `archive`. This tar should be named with `...-instrumented.tar.gz`.
