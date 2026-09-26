# Parameterized Asynchronous FIFO Buffer with Clock Domain Crossing (CDC)

Synthesizable, production-ready Asynchronous FIFO designed in Verilog HDL using Xilinx Vivado. Manages safe, multi-byte data transfers across asynchronous clock domains without data corruption or metastability.

## Architecture & Specifications
- **Write Clock Domain:** 100 MHz (`wclk`)
- **Read Clock Domain:** 40 MHz (`rclk`)
- **Memory Size:** Parameterized 16 x 8-bit Dual-Port RAM
- **CDC Safety:** 2-Stage D Flip-Flop Synchronizers (`sync_2ff.v`)
- **Pointer Format:** Binary-to-Gray Code Conversion to enforce 1-bit transition rule
- **Flag Logic:** Full (`wfull`) and Empty (`rempty`) detection with wrap-around bit checking

## Simulation Waveform (Xilinx Vivado)
![Async FIFO Waveform](async_fifo_waveform.png)

## Modules Included
1. `fifo_mem.v` - Dual-Port RAM Memory Block
2. `sync_2ff.v` - 2-Stage Flip-Flop Synchronizer
3. `wptr_full.v` - Write Pointer & Full Flag Generation
4. `rptr_empty.v` - Read Pointer & Empty Flag Generation
5. `async_fifo.v` - Top-Level RTL Wrapper
6. `tb_async_fifo.v` - Self-Checking Multi-Clock Testbench
