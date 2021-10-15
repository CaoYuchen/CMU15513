#!/usr/bin/env python3

"""Autograder for Cachelab.

The driver tests the correctness of the student's cache simulator and the
correctness and performance of their transpose function.

* It uses ./test-csim to check the correctness of the simulator
* It runs ./test-trans on two different sized matrices (32x32 and 63x65) to
  test the correctness and performance of the transpose function.

"""

import subprocess
import re
import os
import sys
import argparse
import hashlib
import numbers
import collections
import json

# Maximum scores for each part
maxscore = {
    'traces': 10,
    'csim': 60,
    'trans32': 20,
    'trans1024': 10,
}

# Matrix sizes to test for transpose
tests = ((1, 1),
         (7, 2),
         (3, 15),
         (137, 1),
         (6, 60),
         (57, 57),
         (128, 128),
         (32, 32),
         (64, 64),
         (63, 65),
         (1024, 1024))


def computeMissScore(cycles, lower, upper, full_score):
    """Computes the score depending on the number of cache misses."""

    if cycles <= lower:
        return full_score
    if cycles >= upper:
        return 0

    score = (cycles - lower) * 1.0
    range = (upper - lower) * 1.0
    return round((1 - score / range) * full_score, 1)


def test_traces():
    """Check the correctness of the student-written traces."""
    print("Trace correctness")
    print("Running ./traces-driver.py")
    p = subprocess.Popen("./traces-driver.py -D",
                         shell=True, stdout=subprocess.PIPE, encoding='utf-8')
    stdout_data = p.communicate()[0]
    stdout_data = re.split('\n', stdout_data)
    for line in stdout_data:
        if re.match("TRACES_TOTAL", line):
            trace_results = re.findall(r'(\d+)', line)
        else:
            print(line)

    return int(trace_results[0]) if trace_results else 0


def test_csim():
    """Checks the correctness of the cache simulator"""
    print("Part A: Testing cache simulator")
    print("Running ./test-csim")
    p = subprocess.Popen("./test-csim",
                         shell=True, stdout=subprocess.PIPE, encoding='utf-8')
    stdout_data = p.communicate()[0]

    # Emit the output from test-csim
    stdout_data = re.split('\n', stdout_data)
    for line in stdout_data:
        if re.match("TEST_CSIM_RESULTS", line):
            resultsim = re.findall(r'(\d+)', line)
        else:
            print(line)

    # Compute the scores part A
    return int(resultsim[0]) if resultsim else 0


def run_test_trans(cmd):
    """Runs a test-trans command and returns the cycle count"""
    print("Running %s" % cmd)
    p = subprocess.Popen("%s | grep TEST_TRANS_RESULTS" % cmd,
                         shell=True, stdout=subprocess.PIPE, encoding='utf-8')

    try:
        stdout_data = p.communicate(timeout=30)[0]
    except subprocess.TimeoutExpired:
        p.kill()
        print("Error: command timed out.")
        return None

    if p.returncode != 0:
        print("Error: return code indicates failure:", p.returncode)
        return None

    result = re.match(r'TEST_TRANS_RESULTS=(\d+):(\d+)', stdout_data)
    if result is None or result.group(1) != '1':
        print("Error: return data indicates failure:", stdout_data)
        return None

    return int(result.group(2))


def test_trans():
    """Checks the correctness of the transpose functions"""
    print("Part B: Testing transpose function correctness")

    transOK = True
    for rc in tests:
        r = rc[0]
        c = rc[1]
        cmd = "./test-trans -s -M %d -N %d" % rc
        cycles = run_test_trans(cmd)
        if cycles is None:
            transOK = False

    if transOK:
        # 32x32 transpose
        cmd = "./test-trans -s -M 32 -N 32"
        cycles32 = run_test_trans(cmd)
        if cycles32 is None:
            transOK = False

        # 1024x1024 transpose
        cmd = "./test-trans -s -M 1024 -N 1024 -l"
        cycles1024 = run_test_trans(cmd)
        if cycles1024 is None:
            transOK = False

    if transOK:
        trans32_score = computeMissScore(
            cycles32, 36000, 45000, maxscore['trans32'])
        trans1024_score = computeMissScore(
            cycles1024, 35100000, 45000000, maxscore['trans1024'])

    else:  # !transOK
        print("Correctness checks failed.  No credit for part B")
        cycles32 = None
        cycles1024 = None
        trans32_score = 0
        trans1024_score = 0

    return cycles32, cycles1024, trans32_score, trans1024_score


def main():

    # Parse the command line arguments
    p = argparse.ArgumentParser(description="Autograder for Cachelab")
    p.add_argument("-A", action="store_true", dest="autograde",
                   help="emit autoresult string for Autolab")
    args = p.parse_args()
    autograde = args.autograde

    # Compute scores for each part
    traces_score = test_traces()
    csim_cscore = test_csim()
    cycles32, cycles1024, trans32_score, trans1024_score = test_trans()
    total_score = traces_score + csim_cscore + trans32_score + trans1024_score

    # Summarize the results
    print('\nCache Lab summary:')

    total_cycles = None if cycles32 is None or cycles1024 is None \
                   else cycles32 + cycles1024

    results = [
        ('',                     'Points',        'Max pts',              'Cycles'),
        ('Traces correctness',   traces_score,    maxscore['traces'],     '  -  '),
        ('Csim correctness',     csim_cscore,     maxscore['csim'],       '  -  '),
        ('Trans perf 32x32',     trans32_score,   maxscore['trans32'],    cycles32),
        ('Trans perf 1024x1024', trans1024_score, maxscore['trans1024'],  cycles1024),
        ('        Total points', total_score,     sum(maxscore.values()), total_cycles)
    ]

    def formatPoints(x):
        if isinstance(x, numbers.Number):
            return '{:.1f}'.format(x)
        return '{:s}'.format(x)

    def formatCycles(x):
        if x is None:
            return 'invalid'
        if isinstance(x, numbers.Number):
            return '{:,d}'.format(x)
        return '{:s}'.format(x)

    for line in results:
        print('  {:20} {:>10} {:>10} {:>14}'.format(
            line[0], formatPoints(line[1]), line[2], formatCycles(line[3])))

    # Emit autoresult string for Autolab if called with -A option
    if autograde:
        autoresult = collections.OrderedDict([
            ('scores', {'Autograded': total_score}),
            ('scoreboard', [total_score, total_cycles, cycles32, cycles1024]),
        ])
        print(json.dumps(autoresult))


# execute main only if called as a script
if __name__ == "__main__":
    main()
