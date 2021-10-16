/*
 *  CMU 15513
 *  CacheLab part A
 *  Name: Yuchen Cao
 *  AndrewID: yuchenca
 *
 *  csim.c - Cache Simulator
 *  There are 3 main structs: cache_line for cache memory, cache_input for
 * storing arguments from prompt, csim_stats_t for counting the number of
 * different data. The pipeline goes:
 *  1. Initialization of all data above, avoid any errors while malloc/reading
 * file, set cache_input with arguments.
 *  2. Read trace file and parse string to related data, store in cache_line
 * pointer's address.
 *  3. Check hits, misses, dirties, evictions through each line from the trace
 * file, update the data in csim_stats_t, and change the cache_line status.
 */

#include "cachelab.h"
#include <getopt.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define BUF_SIZE 64

typedef struct cache_line {
    unsigned long valid;
    unsigned long tag;
    unsigned long age;
    unsigned long dirty;
} cache_line;

typedef struct cache_input {
    unsigned long h;
    unsigned long v;
    unsigned long s;
    unsigned long E;
    unsigned long b;
} cache_input;

char *file = NULL;
FILE *traceFile;
cache_line *cache = NULL;

int parseOPT(int, char **, cache_input *);
void helper(void);
int init(cache_input *, csim_stats_t *);
void cacheSimulator(cache_input *, csim_stats_t *);
void updateAge(unsigned long, unsigned long, unsigned long);
unsigned long LRU(unsigned long, unsigned long);

/*
 * ParseOPT - get info from arguments
 */
int parseOPT(int argc, char **argv, cache_input *input) {
    input->h = 0;
    input->v = 0;
    input->s = 0;
    input->E = 0;
    input->b = 0;
    // input->file = NULL;

    int opt = 0;
    while ((opt = getopt(argc, argv, "hvs:E:b:t:")) != -1) {
        switch (opt) {
        case 'v':
            input->v = 1;
            break;
        case 's':
            input->s = strtoul(optarg, NULL, 0);
            break;
        case 'E':
            input->E = strtoul(optarg, NULL, 0);
            break;
        case 'b':
            input->b = strtoul(optarg, NULL, 0);
            break;
        case 't':
            file = optarg;
            break;
        case 'h':
            helper();
            return -1;
        default:
            break;
        }
    }

    if (input->s < 0 || input->E <= 0 || input->b < 0 || file == NULL) {
        printf("%s: Missing required argument\n", argv[0]);
        return -1;
    }

    return 0;
}
/*
 * helper printer
 */
void helper(void) {
    printf("Usage: ./csim-ref [-hv] -s <num> -E <num> -b <num> -t <file>\n"
           "Options:\n"
           "  -h         Print this help message.\n"
           "  -v         Optional verbose flag.\n"
           "  -s <num>   Number of set index bits.\n"
           "  -E <num>   Number of lines per set.\n"
           "  -b <num>   Number of block offset bits.\n"
           "  -t <file>  Trace file.\n");
}
/*
 * init - initialize cache parameters
 */
int init(cache_input *input, csim_stats_t *state) {
    state->evictions = 0;
    state->hits = 0;
    state->misses = 0;
    state->dirty_bytes = 0;
    state->dirty_evictions = 0;
    traceFile = fopen(file, "r");
    if (traceFile == NULL) {
        printf("Error opening file!");
        return (-1);
    }

    unsigned long width = (1 << input->s) * input->E * (1 << input->b);
    cache = (cache_line *)calloc(width, sizeof(cache_line));
    if (cache == NULL) {
        printf("Calloc error!");
        return (-1);
    }
    return 0;
}
/*
 * cacheSimulator - main function to read file and parse instruction
 * check cache, change cache & count related data.
 */
void cacheSimulator(cache_input *input, csim_stats_t *state) {
    char buffer[BUF_SIZE];
    const char delimiters[] = ", "; // ',' & ' '
    char *action, *address;
    int bsize;
    unsigned long addr, tag, set;
    unsigned long dirtyBytes = 1 << input->b;

    while (fgets(buffer, BUF_SIZE, traceFile)) {
        action = strtok(buffer, delimiters);
        address = strtok(NULL, delimiters);
        bsize = atoi(strtok(NULL, delimiters));
        // verbose mode
        if (input->v)
            printf("%s %s,%d\n ", action, address, bsize);
        // new incoming address from file
        addr = strtoul(address, NULL, 16);
        tag = addr >> (input->s + input->b);
        set = (addr - (tag << (input->s + input->b))) >> input->b;

        unsigned long invalid_index = 0, LRU_index = 0;
        bool cold_flag = 0, capacity_flag = 0, hit_flag = 0, empty_flag = 0;

        for (unsigned long i = 0; i < input->E; ++i) {
            // Cache hit
            if (cache[set * input->E + i].tag == tag &&
                cache[set * input->E + i].valid) {
                if (input->v)
                    printf("hit\n");
                state->hits++;
                hit_flag = 1;

                if (!strncmp(action, "S", 1) &&
                    !cache[set * input->E + i].dirty) {
                    state->dirty_bytes += dirtyBytes;
                    cache[set * input->E + i].dirty = 1;
                    if (input->v)
                        printf("dirty\n");
                }
                updateAge(set, input->E, i);
                break;
            } else if (!cache[set * input->E + i].valid && !empty_flag) {
                invalid_index = i;
                empty_flag = 1;
            }
        }

        if (!hit_flag) {
            if (empty_flag) {
                cold_flag = 1;
            } else {
                LRU_index = LRU(set, input->E);
                capacity_flag = 1;
            }
        }

        /* Cold miss */
        if (cold_flag) {
            cache[set * input->E + invalid_index].valid = 1;
            cache[set * input->E + invalid_index].tag = tag;
            if (input->v)
                printf("miss:cold\n");
            state->misses++;
            // dirty record
            if (!strncmp(action, "S", 1)) {
                cache[set * input->E + invalid_index].dirty = 1;
                state->dirty_bytes += dirtyBytes;
                if (input->v)
                    printf("dirty\n");
            }
            updateAge(set, input->E, invalid_index);
        }
        /* Capacity miss, need eviction */
        else if (capacity_flag) {
            cache[set * input->E + LRU_index].tag = tag;
            if (input->v)
                printf("miss:capacity\n");
            state->misses++;
            state->evictions++;
            // dirty and evictions record
            if (cache[set * input->E + LRU_index].dirty) {
                state->dirty_bytes -= dirtyBytes;
                state->dirty_evictions += dirtyBytes;
                cache[set * input->E + LRU_index].dirty = 0;
                if (input->v)
                    printf("dirty eviciton\n");
            }
            if (!strncmp(action, "S", 1) &&
                !cache[set * input->E + LRU_index].dirty) {
                state->dirty_bytes += dirtyBytes;
                cache[set * input->E + LRU_index].dirty = 1;
                if (input->v)
                    printf("dirty\n");
            }
            updateAge(set, input->E, LRU_index);
        }
    }
}

// returns the line with the oldest age in the cache
unsigned long LRU(unsigned long set, unsigned long E) {
    unsigned long oldest = cache[set * E].age;
    unsigned long oldest_index = 0;
    for (unsigned long i = 1; i < E; i++) {
        if (cache[set * E + i].age > oldest) {
            oldest = cache[set * E + i].age;
            oldest_index = i;
        }
    }
    return oldest_index;
}

// increments the age for all cache lines except for 'work' one which get set to
// zero
void updateAge(unsigned long set, unsigned long E, unsigned long index) {
    for (unsigned long i = 0; i < E; i++) {
        if (i == index)
            (cache[set * E + i]).age = 0; // reset
        else
            (cache[set * E + i]).age += 1; // increment
    }
}

int main(int argc, char **argv) {
    cache_input input;
    csim_stats_t state;

    // if input -h flag, print helper instruction
    if (parseOPT(argc, argv, &input))
        return -1;
    // if any data has NULL issue, exit
    if (init(&input, &state)) {
        return -1;
    }
    // cache simulator
    cacheSimulator(&input, &state);
    // free heap
    fclose(traceFile);
    free(cache);
    // print result
    printSummary(&state);
    return 0;
}
