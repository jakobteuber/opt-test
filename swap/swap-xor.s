/*
 * Swap rdi and rsi using the xor scheme  10_000 times.
 */
.intel_syntax noprefix

.global run_swap
run_swap:
  /*
   * void run_swap(unsigned long rdi, unsigned long rsi, unsigned long rdx);
   * swap rdi and rsi, repeat rdx times
   */

  loop:
  xor rdi, rsi
  xor rsi, rdi
  xor rdi, rsi

  dec rdx
  jnz loop

  ret
  