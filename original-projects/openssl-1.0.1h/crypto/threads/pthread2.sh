#!/bin/sh
#
# build using pthreads where it's already built into the system
#
/bin/rm -f mttest
gcc -DPTHREADS -fPIC -I../../include -g mttest.c -o mttest -L../.. -lssl -lcrypto -lpthread

