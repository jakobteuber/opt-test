/*
 * Swap rdi and rsi using a temporary value on the stack 10_000 times.
 */
.intel_syntax noprefix

.global run_swap
run_swap:
  /*
   * void run_swap(unsigned long rdi, unsigned long rsi, unsigned long rdx);
   * swap rdi and rsi, repeat rdx times
   */

  loop:
  push rdi
  mov rdi, rsi
  pop rsi

  dec rdx
  jnz loop

  ret
