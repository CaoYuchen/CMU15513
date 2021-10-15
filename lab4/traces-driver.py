#!/usr/bin/env python3

'''
This file tests student written cachelab traces. It tests them by running
traces on csim-ref and comparing the hits/misses/evictions with the expected
hits/misses/evictions. It also checks if the trace is well formatted.

If run with the -f [tracefile] it only judges whether tracefile is well written
or not.

author: Jeremy Dropkin
'''

import subprocess
import re
import os
import argparse

# Trace files used for grading
path_to_traces = "traces/traces/"
traces = [
    os.path.join(path_to_traces, "tr1.trace"),
    os.path.join(path_to_traces, "tr2.trace"),
    os.path.join(path_to_traces, "tr3.trace"),
]

# Format: [s, E, b]
params = [[3, 1, 4], [1, 3, 4], [2, 3, 4]]
max_ops = [5, 5, 10]
# Format: [hits, misses, evictions]
expected = [[2, None, 1], [2, 2, None], [5, 4, 1]]
maxPoints = [3, 3, 4]


def count_ops(trace):
    count = 0
    for op in ["L", "S"]:
        count += trace.count(op)
    return count


def is_valid_trace(trace):
    """Verify that the trace file being run is well written.
    Each line of the trace must be in the format "(L|S) addr,len"
    """

    try:
        with open(trace) as f:
            trace_data = f.read()
    except:
        print("Could not open {}".format(trace))
        return False

    # Check for empty file
    if not trace_data:
        print("{} is empty, trace contents expected.".format(trace))
        return False

    # Check each line in the file is a valid instruction
    instructions = trace_data.rstrip().splitlines()
    for i, instr in enumerate(instructions, start=1):
        # Note: extra characters at the end of the line are probably ok
        if re.match(r"[LS] [0-9a-fA-F]+,[0-9]+", instr) is None:
            print("\"{}\" is not a well written instruction (line {})".format(instr, i))
            return False

    return True


def run_trace(trace, parameters, max_ops):
    """Return the hits, misses, and evictions from running a trace
    This uses the csim-ref program to compute statistics for the given trace.
    """

    # Read trace data
    try:
        with open(trace) as f:
            trace_data = f.read()
    except FileNotFoundError:
        print("Could not find {}".format(trace))
        return None

    # Check operation count in trace is within the limit
    if count_ops(trace_data) > max_ops:
        print("{} contains too many instructions, use a maximum of {} for this trace".format(
            trace, max_ops))
        return None

    # Check trace is valid
    if not is_valid_trace(trace):
        return None

    # Remove previous simultaion results
    try:
        os.remove(".csim_results")
    except FileNotFoundError:
        pass

    # Run csim-ref with the given trace
    p = subprocess.run(
        [
            "./csim-ref",
            "-s", str(parameters[0]),
            "-E", str(parameters[1]),
            "-b", str(parameters[2]),
            "-t", trace,
        ],
        stdout=subprocess.DEVNULL)

    # Not run successfully
    if p.returncode != 0:
        print("Running {} on csim-ref failed!".format(trace))
        return None

    # Read results from simulation
    try:
        with open(".csim_results", "r") as f:
            results = f.read()
    except:
        print("Could not find results file!")
        return None

    results = list(map(int, results.split()))

    # Return hits, misses, evictions
    # Only care about the first 3 values recorded
    return (results[0], results[1], results[2])


def cmp_expected(real, exp):
    """Compares a value from a trace with an expected value.
    If expected is -1, the result doesn't matter
    """

    for real_val, exp_val in zip(real, exp):
        if exp_val is not None and real_val != exp_val:
            return False
    return True


def fmt_expected_val(exp_val):
    """Formats an expected trace value as a string."""
    if exp_val is None:
        return 'any'
    return '{}'.format(exp_val)


def main():
    # Parse command line arguments
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group()
    group.add_argument("-f", help="Verify a specific trace is well written")
    group.add_argument("-D", action="store_true", dest="autograde",
                       help="Only emit numerical result from driver.py")
    args = parser.parse_args()
    autograde = args.autograde

    # If run with the -f flag, check if a tracefile is well written
    if args.f != None:
        # Check if a trace is well written
        trace = args.f
        if trace.endswith(".trace"):
            if is_valid_trace(trace):
                print("{} is a well written trace".format(trace))
                return
        else:
            print("Please specify a .trace file!")
            return

    # Run all traces
    else:
        points = [0, 0, 0]

        for i, tr in enumerate(traces):
            # Run a trace
            trace_results = run_trace(tr, params[i], max_ops[i])
            if trace_results is None:
                print("Error running {}\n".format(tr))
                continue

            # Compare trace results with expected results
            if cmp_expected(trace_results, expected[i]):
                points[i] = maxPoints[i]

            # Print results
            expected_results = map(fmt_expected_val, expected[i])
            if i != 0:
                print()
            print("Score for {}: {} / {}".format(tr, points[i], maxPoints[i]))
            print("    Your trace:  "
                  "Hits: {:>3}, Misses: {:>3}, Evictions: {:>3}".format(*trace_results))
            print("    Expected:    "
                  "Hits: {:>3}, Misses: {:>3}, Evictions: {:>3}".format(*expected_results))

        # Print result to be interpreted by driver
        if autograde:
            print("TRACES_TOTAL: %d" % sum(points))


if __name__ == "__main__":
    main()
