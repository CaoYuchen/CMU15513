/* Fcyc measures the speed of any "test function."  Such a function
   is passed a list of integer parameters, which it may interpret
   in any way it chooses.

   Time can be measured in seconds or clock cycles.
*/
#ifndef FCYC_H__
#define FCYC_H__ 1

#include <stdbool.h>

typedef void (*test_funct)(void *);

/* Compute number of cycles used by function f on given set of parameters */
double fcyc(test_funct f, void *args);

/* Compute number of cycles used by function f on given set of parameters */
double fsec(test_funct f, void *args);

/***********************************************************/
/* Set the various parameters used by measurement routines */

/* Sets minimum number of timer ticks to resolve time.  Default = 1000 */
void set_fcyc_min_ticks(unsigned long t);

/* Sets minimum number of repetitions of function.  Default = 8 */
void set_fcyc_min_reps(unsigned long r);

/* When set, will run code to clear cache before each measurement
   Default = false
*/
void set_fcyc_clear_cache(bool clear);

/* Set size of cache to use when clearing cache
   Default = 1<<19 (512KB)
*/
void set_fcyc_cache_size(unsigned long int bytes);

/* Set size of cache block
   Default = 32
*/
void set_fcyc_cache_block(unsigned long int bytes);

/* When set, will attempt to compensate for timer interrupt overhead
   Default = 0
*/
void set_fcyc_compensate(unsigned long int compensate);

/* Value of K in K-best
   Default = 3
*/
void set_fcyc_k(unsigned long int k);

/* Maximum number of samples attempting to find K-best within some tolerance.
   When exceeded, just return best sample found.
   Default = 20
*/
void set_fcyc_maxsamples(unsigned long int maxsamples);

/* Tolerance required for K-best
   Default = 0.01
*/
void set_fcyc_epsilon(double epsilon);

#endif /* fcyc.h */
