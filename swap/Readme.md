# Swapping two registers
It’s a common bit of “fun bit-twiddling wisdom” that you can swap two variables without any temporary storage space using xor using the following scheme:

    x ^= y;
    y ^= x;
    x ^= y;

It becomes clearer, what’s going on, by expanding the computation:

    y_new = y_old ^ (x_old ^ y_old)
          = y_old ^ y_old ^ x_old
          = x_old
    x_new = (x_old ^ y_old) ^ y_old ^ (x_old ^ y_old)
          = y_old

However, on modern hardware, this is not worthwhile: Swapping with a temporary register is much faster, and even if no temporary register is available, stack access is still fast enough due to caches, that the xor strategy is not beneficial. In fact, I cannot detect a difference between swapping via register and stack slot on my machine.

## Benchmarks 
Run on 12th Gen Intel(R) Core(TM) i5-1235U, Fedora 42.

Run each swap scheme 1 << 32 times.

| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `./swap-xor.run` | 2.975 ± 0.026 | 2.960 | 3.047 | 3.00 ± 0.03 |
| `./swap-temp.run` | 0.993 ± 0.006 | 0.986 | 1.001 | 1.00 ± 0.01 |
| `./swap-stack.run` | 0.991 ± 0.005 | 0.985 | 1.000 | 1.00 |
