void run_swap(unsigned long rdi, unsigned long rsi, unsigned long rdx);

int main() { run_swap(0, 1, 1ULL << 32); }
