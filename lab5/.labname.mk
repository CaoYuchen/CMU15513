LAB = malloclab
LAB_CHECKPOINT = malloclabcheckpoint
LAB_FINAL = malloclab
COURSECODE = 15213-f21
SAN_LIBRARY_PATH = /afs/cs.cmu.edu/academic/class/15213/lib/clang/7.0.0
ifneq (,$(wildcard autograde-lib/clang/))
  SAN_LIBRARY_PATH = autograde-lib/clang/
endif
