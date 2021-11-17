#
# Makefile for the CS:APP Shell Lab
#
# Type "make" to build your shell and driver
#

include .labname.mk

# Compiler / linker options
CC       = gcc
CFLAGS   = -std=c11 -O2 -g -Werror -Wall -Wextra -Wpedantic -Wconversion
CFLAGS  += -Wstrict-prototypes -Wmissing-prototypes -Wwrite-strings
CFLAGS  += -Wno-unused-function -Wno-unused-parameter
CPPFLAGS = -D_GNU_SOURCE=1 -D_FORTIFY_SOURCE=2 -I.
LDLIBS   = -Wl,--as-needed -lrt -lpthread

# Path to LLVM when running on autograder and shark cluster
# For tshlab, LLVM is only used for clang-format
ifneq (,$(wildcard /usr/lib/llvm-7/bin/))
  LLVM_PATH = /usr/lib/llvm-7/bin/
else
  ifneq (,$(wildcard /usr/local/depot/llvm-7.0/bin/))
    LLVM_PATH = /usr/local/depot/llvm-7.0/bin/
  endif
endif
CLANG_FORMAT = $(LLVM_PATH)clang-format


# Functions to interpose in wrapper.c
WRAPCFLAGS :=
WRAPCFLAGS += -Wl,--wrap=fork
WRAPCFLAGS += -Wl,--wrap=kill
WRAPCFLAGS += -Wl,--wrap=killpg
WRAPCFLAGS += -Wl,--wrap=waitpid
WRAPCFLAGS += -Wl,--wrap=execve
WRAPCFLAGS += -Wl,--wrap=execv
WRAPCFLAGS += -Wl,--wrap=execvpe
WRAPCFLAGS += -Wl,--wrap=execvp
WRAPCFLAGS += -Wl,--wrap=tcsetpgrp
WRAPCFLAGS += -Wl,--wrap=signal
WRAPCFLAGS += -Wl,--wrap=sigaction
WRAPCFLAGS += -Wl,--wrap=sigsuspend
WRAPCFLAGS += -Wl,--wrap=sigprocmask
WRAPCFLAGS += -Wl,--wrap=printf
WRAPCFLAGS += -Wl,--wrap=fprintf
WRAPCFLAGS += -Wl,--wrap=sprintf
WRAPCFLAGS += -Wl,--wrap=snprintf
WRAPCFLAGS += -Wl,--wrap=init_job_list
WRAPCFLAGS += -Wl,--wrap=job_get_pid
WRAPCFLAGS += -Wl,--wrap=job_set_state


# Auxiliary programs
HELPER_PROGS :=
HELPER_PROGS += myspin1
HELPER_PROGS += myspin2
HELPER_PROGS += myenv
HELPER_PROGS += myintp
HELPER_PROGS += myints
HELPER_PROGS += mytstpp
HELPER_PROGS += mytstps
HELPER_PROGS += mysplit
HELPER_PROGS += mysplitp
HELPER_PROGS += mycat
HELPER_PROGS += mysleepnprint
HELPER_PROGS += mysigfun
HELPER_PROGS += mytstpandspin
HELPER_PROGS += myspinandtstps
HELPER_PROGS += myusleep

# Prefix all helper programs with testprogs/
HELPER_PROGS := $(HELPER_PROGS:%=testprogs/%)

# List all build targets and header files
HANDIN_TAR = tshlab-handin.tar

FILES = sdriver runtrace tsh $(HELPER_PROGS) $(HANDIN_TAR)
DEPS = config.h csapp.h tsh_helper.h testprogs/helper.h


.PHONY: all
all: $(FILES)

# Compile tsh with link-time interpositioning
tsh: LDFLAGS += $(WRAPCFLAGS)
tsh: tsh.o wrapper.o csapp.o tsh_helper.o

sdriver: sdriver.o
runtrace: runtrace.o csapp.o

# Header dependencies
csapp.o:                    csapp.c csapp.h
runtrace.o:                 runtrace.c config.h csapp.h
sdriver.o:                  sdriver.c config.h csapp.h
tsh.o:                      tsh.c csapp.h tsh_helper.h
tsh_helper.o:               tsh_helper.c csapp.h tsh_helper.h
wrapper.o:                  wrapper.c csapp.h tsh_helper.h
testprogs/hello.o:          testprogs/hello.c
testprogs/mycat.o:          testprogs/mycat.c
testprogs/myenv.o:          testprogs/myenv.c
testprogs/myintp.o:         testprogs/myintp.c config.h testprogs/helper.h
testprogs/myints.o:         testprogs/myints.c config.h testprogs/helper.h
testprogs/mysigfun.o:       testprogs/mysigfun.c config.h testprogs/helper.h
testprogs/mysleepnprint.o:  testprogs/mysleepnprint.c config.h testprogs/helper.h
testprogs/myspin1.o:        testprogs/myspin1.c config.h testprogs/helper.h
testprogs/myspin2.o:        testprogs/myspin2.c config.h testprogs/helper.h
testprogs/myspinandtstps.o: testprogs/myspinandtstps.c config.h testprogs/helper.h
testprogs/mysplit.o:        testprogs/mysplit.c config.h testprogs/helper.h
testprogs/mysplitp.o:       testprogs/mysplitp.c config.h
testprogs/mytstpandspin.o:  testprogs/mytstpandspin.c config.h testprogs/helper.h
testprogs/mytstpp.o:        testprogs/mytstpp.c config.h testprogs/helper.h
testprogs/mytstps.o:        testprogs/mytstps.c
testprogs/myusleep.o:       testprogs/myusleep.c


# Clean up
.PHONY: clean
clean:
	rm -f *.o *~ $(FILES)
	rm -rf runtrace.tmp


# Include rules for submit, format, etc
FORMAT_FILES = tsh.c
HANDIN_FILES = tsh.c .clang-format
include helper.mk


# Add check-format dependencies
submit: | check-format
tsh $(HANDIN_TAR): | check-format
