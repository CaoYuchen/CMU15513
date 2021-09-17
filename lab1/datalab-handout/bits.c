/*
 * CS:APP Data Lab
 *
 * <Joshua Cao; Andrew id: yuchenca>
 *
 * bits.c - Source file with your solutions to the Lab.
 *          This is the file you will hand in to your instructor.
 */

/* Instructions to Students:

You will provide your solution to the Data Lab by
editing the collection of functions in this source file.

INTEGER CODING RULES:

  Replace the "return" statement in each function with one
  or more lines of C code that implements the function. Your code
  must conform to the following style:

  long Funct(long arg1, long arg2, ...) {
      // brief description of how your implementation works
      long var1 = Expr1;
      ...
      long varM = ExprM;

      varJ = ExprJ;
      ...
      varN = ExprN;
      return ExprR;
  }

  Each "Expr" is an expression using ONLY the following:
  1. (Long) integer constants 0 through 255 (0xFFL), inclusive. You are
      not allowed to use big constants such as 0xffffffffL.
  3. Function arguments and local variables (no global variables).
  4. Local variables of type int and long
  5. Unary integer operations ! ~
     - Their arguments can have types int or long
     - Note that ! always returns int, even if the argument is long
  6. Binary integer operations & ^ | + << >>
     - Their arguments can have types int or long
  7. Casting from int to long and from long to int

  Some of the problems restrict the set of allowed operators even further.
  Each "Expr" may consist of multiple operators. You are not restricted to
  one operator per line.

  You are expressly forbidden to:
  1. Use any control constructs such as if, do, while, for, switch, etc.
  2. Define or use any macros.
  3. Define any additional functions in this file.
  4. Call any functions.
  5. Use any other operations, such as &&, ||, -, or ?:
  6. Use any form of casting other than between int and long.
  7. Use any data type other than int or long.  This implies that you
     cannot use arrays, structs, or unions.

  You may assume that your machine:
  1. Uses 2s complement representations for int and long.
  2. Data type int is 32 bits, long is 64.
  3. Performs right shifts arithmetically.
  4. Has unpredictable behavior when shifting if the shift amount
     is less than 0 or greater than 31 (int) or 63 (long)

EXAMPLES OF ACCEPTABLE CODING STYLE:
  //
  // pow2plus1 - returns 2^x + 1, where 0 <= x <= 63
  //
  long pow2plus1(long x) {
     // exploit ability of shifts to compute powers of 2
     // Note that the 'L' indicates a long constant
     return (1L << x) + 1L;
  }

  //
  // pow2plus4 - returns 2^x + 4, where 0 <= x <= 63
  //
  long pow2plus4(long x) {
     // exploit ability of shifts to compute powers of 2
     long result = (1L << x);
     result += 4L;
     return result;
  }

FLOATING POINT CODING RULES

For the problems that require you to implement floating-point operations,
the coding rules are less strict.  You are allowed to use looping and
conditional control.  You are allowed to use both ints and unsigneds.
You can use arbitrary integer and unsigned constants. You can use any
arithmetic, logical, or comparison operations on int or unsigned data.

You are expressly forbidden to:
  1. Define or use any macros.
  2. Define any additional functions in this file.
  3. Call any functions.
  4. Use any form of casting.
  5. Use any data type other than int or unsigned.  This means that you
     cannot use arrays, structs, or unions.
  6. Use any floating point data types, operations, or constants.


NOTES:
  1. Use the dlc (data lab checker) compiler (described in the handout) to
     check the legality of your solutions.
  2. Each function has a maximum number of operations (integer, logical,
     or comparison) that you are allowed to use for your implementation
     of the function.  The max operator count is checked by dlc.
     Note that assignment ('=') is not counted; you may use as many of
     these as you want without penalty.
  3. Use the btest test harness to check your functions for correctness.
  4. Use the BDD checker to formally verify your functions
  5. The maximum number of ops for each function is given in the
     header comment for each function. If there are any inconsistencies
     between the maximum ops in the writeup and in this file, consider
     this file the authoritative source.
*/

/* CAUTION: Do not add an #include of <stdio.h> (or any other C
   library header) to this file.  C library headers almost always
   contain constructs that dlc does not understand.  For debugging,
   you can use printf, which is declared for you just below.  It is
   normally bad practice to declare C library functions by hand, but
   in this case it's less trouble than any alternative.

   CAUTION: You must remove all your debugging printf's again before
   submitting your code or testing it with dlc or the BDD checker.  */

extern int printf(const char *, ...);

/* Edit the functions below.  Good luck!  */
// 2
/*
 * copyLSB - set all bits of result to least significant bit of x
 *   Examples:
 *     copyLSB(5L) = 0xFFFFFFFFFFFFFFFFL,
 *     copyLSB(6L) = 0x0000000000000000L
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 5
 *   Rating: 2
 */
long copyLSB(long x) {
    return ~(x & 1L) + 1L;
}
/*
 * distinctNegation - returns 1 if x != -x.
 *     and 0 otherwise
 *   Legal ops: ! ~ & ^ | +
 *   Max ops: 5
 *   Rating: 2
 */
long distinctNegation(long x) {
    return !!(x ^ (~x + 1L));
}
/*
 * getByte - Extract byte n from word x
 *   Bytes numbered from 0 (least significant) to 7 (most significant)
 *   Examples: getByte(0x12345678L,1) = 0x56L
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 6
 *   Rating: 2
 */
long getByte(long x, long n) {
    return x >> (n << 3) & 255L;
}
/*
 * anyEvenBit - return 1 if any even-numbered bit in word set to 1
 *   where bits are numbered from 0 (least significant) to 63 (most significant)
 *   Examples anyEvenBit(0xAL) = 0L, anyEvenBit(0xEL) = 1L
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 14
 *   Rating: 2
 */
long anyEvenBit(long x) {
    long even = 0x0000000000000055L;
    even = even + (even << 8);
    even = even + (even << 16);
    even = even + (even << 32);
    return !!(x & even);
}
// 3
/*
 * conditional - same as x ? y : z
 *   Example: conditional(2,4L,5L) = 4L
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 16
 *   Rating: 3
 */
long conditional(long x, long y, long z) {
    long boolean = ~(long)!!(x ^ 0L) + 1L;
    return (boolean & y) | (~boolean & z);
}
/*
 * subtractionOK - Determine if can compute x-y without overflow
 *   Example: subtractionOK(0x8000000000000000L,0x8000000000000000L) = 1L,
 *            subtractionOK(0x8000000000000000L,0x7000000000000000L) = 0L,
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 20
 *   Rating: 3
 */
long subtractionOK(long x, long y) {
    long subtract = x + ~y + 1L;
    long notOverflow =
        (long)!((x >> 63 ^ y >> 63) & !(y >> 63 ^ subtract >> 63));
    return notOverflow;
}
/*
 * isLessOrEqual - if x <= y  then return 1, else return 0
 *   Example: isLessOrEqual(4L,5L) = 1L.
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 24
 *   Rating: 3
 */
long isLessOrEqual(long x, long y) {
    long subtract = y + ~x + 1L;
    long notOverflow = !((x >> 63 ^ y >> 63) & !(x >> 63 ^ subtract >> 63));
    int LessOrEqual =
        (notOverflow & !(subtract >> 63)) | ((!notOverflow) & !(y >> 63));
    return LessOrEqual;
}
/*
 * bitMask - Generate a mask consisting of all 1's
 *   between lowbit and highbit
 *   Examples: bitMask(5L,3L) = 0x38L
 *   Assume 0 <= lowbit < 64, and 0 <= highbit < 64
 *   If lowbit > highbit, then mask should be all 0's
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 16
 *   Rating: 3
 */
long bitMask(long highbit, long lowbit) {
    long minusOne = ~1L + 1L;
    long low = (1L << lowbit) + minusOne;
    long high = ~((1L << highbit) + minusOne + (1L << highbit));
    return ~(high | low);
}
// 4
/*
 * trueThreeFourths - multiplies by 3/4 rounding toward 0,
 *   avoiding errors due to overflow
 *   Examples:
 *    trueThreeFourths(11L) = 8
 *    trueThreeFourths(-9L) = -6
 *    trueThreeFourths(4611686018427387904L) = 3458764513820540928L (no
 * overflow) Legal ops: ! ~ & ^ | + << >> Max ops: 20 Rating: 4
 */
long trueThreeFourths(long x) {
    long divideFour = x >> 2;
    long remain = x & 3L;
    long sign = x >> 63L;
    long threeFourth = divideFour + (divideFour << 1) +
                       ((remain + (remain << 1) + (sign & 3L)) >> 2);

    return threeFourth;
}
/*
 * bitCount - returns count of number of 1's in word
 *   Examples: bitCount(5L) = 2, bitCount(7L) = 3
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 50
 *   Rating: 4
 */
long bitCount(long x) {
    long count;
    long localMask = 255L;
    long broadMask = 1L | 1L << 8;
    broadMask = broadMask | (broadMask << 16);
    broadMask = broadMask | (broadMask << 32);
    count = (x & broadMask) + ((x >> 1) & broadMask) +
                 ((x >> 2) & broadMask) + ((x >> 3) & broadMask) +
                 ((x >> 4) & broadMask) + ((x >> 5) & broadMask) +
                 ((x >> 6) & broadMask) + ((x >> 7) & broadMask);
    count = (count & localMask) + ((count >> 8) & localMask) +
            ((count >> 16) & localMask) + ((count >> 24) & localMask) +
            ((count >> 32) & localMask) + ((count >> 40) & localMask) +
            ((count >> 48) & localMask) + ((count >> 56) & localMask);

    return count;
}
/*
 * logicalNeg - implement the ! operator, using all of
 *              the legal operators except !
 *   Examples: logicalNeg(3L) = 0L, logicalNeg(0L) = 1L
 *   Legal ops: ~ & ^ | + << >>
 *   Max ops: 12
 *   Rating: 4
 */
long logicalNeg(long x) {
    return ((x >> 63) | ((~x + 1L) >> 63)) + 1L;
}
