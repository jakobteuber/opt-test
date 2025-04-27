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

`hyperfine "./swap-xor" "./swap-temp" "./swap-stack"`
### Benchmark 1: `./swap-xor`
    Time (mean ± σ):      2.954 s ±  0.003 s    [User: 2.950 s, System: 0.001 s]   
    Range (min … max):    2.949 s …  2.957 s    10 runs

### Benchmark 2: `./swap-temp`
    Time (mean ± σ):     988.5 ms ±   5.0 ms    [User: 986.7 ms, System: 0.8 ms]
    Range (min … max):   983.7 ms … 998.9 ms    10 runs
 
### Benchmark 3: `./swap-stack`
    Time (mean ± σ):     987.4 ms ±   2.6 ms    [User: 985.7 ms, System: 0.7 ms]
    Range (min … max):   983.3 ms … 992.5 ms    10 runs
 
### Summary
    ./swap-stack ran
        1.00 ± 0.01 times faster than ./swap-temp
        2.99 ± 0.01 times faster than ./swap-xor