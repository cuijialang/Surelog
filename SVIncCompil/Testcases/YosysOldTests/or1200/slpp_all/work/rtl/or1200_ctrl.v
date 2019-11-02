//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Instruction decode                                 ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Majority of instruction decoding is performed here.         ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//
// $Log: or1200_ctrl.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 

// synopsys translate_off
`timescale 1ps/1ps
// synopsys translate_on
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_defines.v,v $
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//

//
// Target ASIC memories
//
//`define OR1200_ARTISAN_SSP
//`define OR1200_ARTISAN_SDP
//`define OR1200_ARTISAN_STP
//`define OR1200_VIRTUALSILICON_SSP
//`define OR1200_VIRTUALSILICON_STP_T1
//`define OR1200_VIRTUALSILICON_STP_T2

//
// Do not implement Data cache
//

//
// Do not implement Insn cache
//

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC optimized and generic multiplier
//
//`define OR1200_GENERIC_MULTP2_32X32

//
// Size/type of insn/data cache if implemented
//
// `define OR1200_IC_1W_4KB
// `define OR1200_IC_1W_8KB
// `define OR1200_DC_1W_8KB



//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//

//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//

//
// LOG all WISHBONE accesses
//

//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//

//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//

//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//

//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//

//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//

//
// Implement carry bit SR[OV]
//
// Compiler doesn't use this, but other code may like
// to.
//

//
// Implement carry bit SR[OVE]
//
// Overflow interrupt indicator. When enabled, SR[OV] flag
// does not remain asserted after exception.
//


//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try to find which synthesizes with
// most efficient logic use or highest speed.
//
//`define OR1200_IMPL_ALU_COMP1
//`define OR1200_IMPL_ALU_COMP2

//
// Implement Find First/Last '1'
//

//
// Implement l.cust5 ALU instruction
//
//`define OR1200_IMPL_ALU_CUST5

//
// Implement l.extXs and l.extXz instructions
//

//
// Implement multiplier
//
// By default multiplier is implemented
//

//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier (non-serial) needs to be
// implemented.
//
//`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area.
//
//

//
// Serial multiplier.
//
//`define OR1200_MULT_SERIAL

//
// Serial divider.
// Uncomment to use a serial divider, otherwise will
// be a generic parallel implementation.
//

//
// Implement HW Single Precision FPU
//
//`define OR1200_FPU_IMPLEMENTED

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)

//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
//`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 

//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//
//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//
    
//
// ALUOPs
//
/* LS-nibble encodings correspond to bits [3:0] of instruction */

/* Values sent to ALU from decode unit - not defined by ISA */

// ALU instructions second opcode field

//
// MACOPs
//

//
// Shift/rotate ops
//

//
// Zero/Sign Extend ops
//

// Execution cycles per instruction

// Execution control which will "wait on" a module to finish


// Operand MUX selects

//
// BRANCHOPs
//

//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store

// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31

// FETCHOPs

//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//

// Compare instructions

//
// FP OPs
//
// MSbit indicates FPU operation valid
//
// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles
// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 
// FP Compare instructions

//
// TAGs for instruction bus
//

//
// TAGs for data bus
//


//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word

//
// Instruction opcode groups (basic)
//
/* */
/* */
/* */
/* */

/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//

//
// N part width
//

//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//


/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group

// Width of the group bits

// Bits that define offset inside the group

// List of groups

/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//

//
// SR bits
//

//
// Bits that define offset inside the group
//

//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//


//
// FPCSR bits
//

/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)

// PMR offset inside PM group of registers

// PM group

// Define if PMR can be read/written at any address inside PM group

// Define if reading PMR is allowed

// Define if unused PMR bits should be zero


/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented

//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 

// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//

// Position of offset bits inside SPR address

// DCR bits

// DMR1 bits

// DMR2 bits

// DWCR bits

// DSR bits

// DRR bits

// Define if reading DU regs is allowed

// Define if unused DU registers bits should be zero

// Define if IF/LSU status is not needed by devel i/f

/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented

// Define number of interrupt inputs (2-31)

// Address offsets of PIC registers inside PIC group

// Position of offset bits inside SPR address

// Define if you want these PIC registers to be implemented

// Define if reading PIC registers is allowed

// Define if unused PIC register bits should be zero


/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented

// Address offsets of TT registers inside TT group

// Position of offset bits inside SPR group

// Define if you want these TT registers to be implemented

// TTMR bits

// Define if reading TT registers is allowed


//////////////////////////////////////////////
//
// MAC
//

//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]


//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//

//
// DTLBMR fields
//

//
// DTLBTR fields
//

//
// DTLB configuration
//

//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//


//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//

//
// ITLBMR fields
//

//
// ITLBTR fields
//

//
// ITLB configuration
//

//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//


/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 4 for 16 byte line, 5 for 32 byte lines.
 
//
// IC configurations
//


/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 4 for 16 bytes, 5 for 32 bytes
 
// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//

// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions
// Data cache group SPR addresses

//
// DC configurations
//


/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//


/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//

//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented

// Define if you want full address decode inside SYS group

// Offsets of VR, UPR and CFGR registers

// VR fields

// VR values

// UPR fields

// UPR values

// CPUCFGR fields

// CPUCFGR values
     

// DMMUCFGR fields

// DMMUCFGR values

// IMMUCFGR fields

// IMMUCFGR values

// DCCFGR fields

// DCCFGR values

// ICCFGR fields

// ICCFGR values

// DCFGR fields

// DCFGR values

///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
//                                                                           //
// Allows a definable boot address, potentially different to the usual reset //
// vector to allow for power-on code to be run, if desired.                  //
//                                                                           //
// OR1200_BOOT_ADR should be the 32-bit address of the boot location         //
//                                                                           //
// For default reset behavior uncomment the settings under the "Boot 0x100"  //
// comment below.                                                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// Boot from 0xf0000100
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 
module or1200_ctrl
  (
   // Clock and reset
   clk, rst,
   
   // Internal i/f
   except_flushpipe, extend_flush, if_flushpipe, id_flushpipe, ex_flushpipe, 
   wb_flushpipe,
   id_freeze, ex_freeze, wb_freeze, if_insn, id_insn, ex_insn, abort_mvspr, 
   id_branch_op, ex_branch_op, ex_branch_taken, pc_we, 
   rf_addra, rf_addrb, rf_rda, rf_rdb, alu_op, alu_op2, mac_op,
   comp_op, rf_addrw, rfwb_op, fpu_op,
   wb_insn, id_simm, ex_simm, id_branch_addrtarget, ex_branch_addrtarget, sel_a,
   sel_b, id_lsu_op,
   cust5_op, cust5_limm, id_pc, ex_pc, du_hwbkpt, 
   multicycle, wait_on, wbforw_valid, sig_syscall, sig_trap,
   force_dslot_fetch, no_more_dslot, id_void, ex_void, ex_spr_read, 
   ex_spr_write, 
   id_mac_op, id_macrc_op, ex_macrc_op, rfe, except_illegal, dc_no_writethrough
   );

//
// I/O
//
input					clk;
input					rst;
input					id_freeze;
input					ex_freeze /* verilator public */;
input					wb_freeze /* verilator public */;
output					if_flushpipe;
output					id_flushpipe;
output					ex_flushpipe;
output					wb_flushpipe;
input					extend_flush;
input					except_flushpipe;
input                           abort_mvspr ;
input	[31:0]			if_insn;
output	[31:0]			id_insn;
output	[31:0]			ex_insn /* verilator public */;
output	[3-1:0]		ex_branch_op;
output	[3-1:0]		id_branch_op;
input						ex_branch_taken;
output	[5-1:0]	rf_addrw;
output	[5-1:0]	rf_addra;
output	[5-1:0]	rf_addrb;
output					rf_rda;
output					rf_rdb;
output	[5-1:0]		alu_op;
output [4-1:0] 		alu_op2;
output	[3-1:0]		mac_op;
output	[4-1:0]		rfwb_op;
output  [8-1:0] 		fpu_op;      
input					pc_we;
output	[31:0]				wb_insn;
output	[31:2]				id_branch_addrtarget;
output	[31:2]				ex_branch_addrtarget;
output	[2-1:0]		sel_a;
output	[2-1:0]		sel_b;
output	[4-1:0]		id_lsu_op;
output	[4-1:0]		comp_op;
output	[3-1:0]		multicycle;
output  [2-1:0] 		wait_on;   
output	[4:0]				cust5_op;
output	[5:0]				cust5_limm;
input   [31:0]                          id_pc;
input   [31:0]                          ex_pc;
output	[31:0]				id_simm;
output	[31:0]				ex_simm;
input					wbforw_valid;
input					du_hwbkpt;
output					sig_syscall;
output					sig_trap;
output					force_dslot_fetch;
output					no_more_dslot;
output					id_void;
output					ex_void;
output					ex_spr_read;
output					ex_spr_write;
output	[3-1:0]	id_mac_op;
output					id_macrc_op;
output					ex_macrc_op;
output					rfe;
output					except_illegal;
output  				dc_no_writethrough;
   
				
//
// Internal wires and regs
//
reg	[3-1:0]		id_branch_op;
reg	[3-1:0]		ex_branch_op;
reg	[5-1:0]		alu_op;
reg [4-1:0]      		alu_op2;
wire					if_maci_op;
wire	[3-1:0]		mac_op;
wire					ex_macrc_op;
reg	[31:0]				id_insn /* verilator public */;
reg	[31:0]				ex_insn /* verilator public */;
reg	[31:0]				wb_insn /* verilator public */;
reg	[5-1:0]	rf_addrw;
reg	[5-1:0]	wb_rfaddrw;
reg	[4-1:0]		rfwb_op;
reg	[2-1:0]		sel_a;
reg	[2-1:0]		sel_b;
reg					sel_imm;
reg	[4-1:0]		id_lsu_op;
reg	[4-1:0]		comp_op;
reg	[3-1:0]		multicycle;
reg     [2-1:0] 		wait_on;      
reg 	[31:0]				id_simm;
reg 	[31:0]				ex_simm;
reg					sig_syscall;
reg					sig_trap;
reg					except_illegal;
wire					id_void;
wire					ex_void;
wire                                    wb_void;
reg                                     ex_delayslot_dsi;
reg                                     ex_delayslot_nop;
reg					spr_read;
reg					spr_write;
reg     [31:2]				ex_branch_addrtarget;
   
//
// Register file read addresses
//
assign rf_addra = if_insn[20:16];
assign rf_addrb = if_insn[15:11];
assign rf_rda = if_insn[31] || if_maci_op;
assign rf_rdb = if_insn[30];

//
// Force fetch of delay slot instruction when jump/branch is preceeded by 
// load/store instructions
//
assign force_dslot_fetch = 1'b0;
assign no_more_dslot = (|ex_branch_op & !id_void & ex_branch_taken) | 
		       (ex_branch_op == 3'd6);

assign id_void = (id_insn[31:26] == 6'b000101) & id_insn[16];
assign ex_void = (ex_insn[31:26] == 6'b000101) & ex_insn[16];
assign wb_void = (wb_insn[31:26] == 6'b000101) & wb_insn[16];

assign ex_spr_write = spr_write && !abort_mvspr;
assign ex_spr_read = spr_read && !abort_mvspr;

//
// ex_delayslot_dsi: delay slot insn is in EX stage
// ex_delayslot_nop: (filler) nop insn is in EX stage (before nops 
//                   jump/branch was executed)
//
//  ex_delayslot_dsi & !ex_delayslot_nop - DS insn in EX stage
//  !ex_delayslot_dsi & ex_delayslot_nop - NOP insn in EX stage, 
//       next different is DS insn, previous different was Jump/Branch
//  !ex_delayslot_dsi & !ex_delayslot_nop - normal insn in EX stage
//
always @(posedge clk or posedge rst) begin
        if (rst == (1'b1)) begin
		ex_delayslot_nop <=  1'b0;
		ex_delayslot_dsi <=  1'b0;
	end
	else if (!ex_freeze & !ex_delayslot_dsi & ex_delayslot_nop) begin
		ex_delayslot_nop <=  id_void;
		ex_delayslot_dsi <=  !id_void;
	end
	else if (!ex_freeze & ex_delayslot_dsi & !ex_delayslot_nop) begin
		ex_delayslot_nop <=  1'b0;
		ex_delayslot_dsi <=  1'b0;
	end
	else if (!ex_freeze) begin
		ex_delayslot_nop <=  id_void && ex_branch_taken && 
				     (ex_branch_op != 3'd0) && 
				     (ex_branch_op != 3'd6);
	        ex_delayslot_dsi <=  !id_void && ex_branch_taken && 
				     (ex_branch_op != 3'd0) && 
				     (ex_branch_op != 3'd6);
	end
end

//
// Flush pipeline
//
assign if_flushpipe = except_flushpipe | pc_we | extend_flush;
assign id_flushpipe = except_flushpipe | pc_we | extend_flush;
assign ex_flushpipe = except_flushpipe | pc_we | extend_flush;
assign wb_flushpipe = except_flushpipe | pc_we | extend_flush;

//
// EX Sign/Zero extension of immediates
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		ex_simm <=  32'h0000_0000;
	else if (!ex_freeze) begin
		ex_simm <=  id_simm;
	end
end

//
// ID Sign/Zero extension of immediate
//
always @(id_insn) begin
	case (id_insn[31:26])     // synopsys parallel_case

	// l.addi
	6'b100111:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// l.addic
	6'b101000:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// l.lxx (load instructions)
	6'b100001, 6'b100010,
   6'b100011, 6'b100100,
	6'b100101, 6'b100110:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// l.muli
		6'b101100:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};
	
	// l.maci
	
	// l.mtspr
	6'b110000:
		id_simm = {16'b0, id_insn[25:21], id_insn[10:0]};

	// l.sxx (store instructions)
	6'b110101, 6'b110111, 6'b110110:
		id_simm = {{16{id_insn[25]}}, id_insn[25:21], id_insn[10:0]};

	// l.xori
	6'b101011:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// l.sfxxi (SFXX with immediate)
	6'b101111:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// Instructions with no or zero extended immediate
	default:
		id_simm = {{16'b0}, id_insn[15:0]};

	endcase
end

//
// ID Sign extension of branch offset
//
assign id_branch_addrtarget = {{4{id_insn[25]}}, id_insn[25:0]} + id_pc[31:2];

//
// EX Sign extension of branch offset
//

// pipeline ID and EX branch target address 
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		ex_branch_addrtarget <=  0;
	else if (!ex_freeze) 
		ex_branch_addrtarget <=  id_branch_addrtarget;
end
// not pipelined
//assign ex_branch_addrtarget = {{4{ex_insn[25]}}, ex_insn[25:0]} + ex_pc[31:2];

//
// l.maci in IF stage
//
assign if_maci_op = 1'b0;

//
// l.macrc in ID stage
//
assign id_macrc_op = 1'b0;

//
// l.macrc in EX stage
//
assign ex_macrc_op = 1'b0;

//
// cust5_op, cust5_limm (L immediate)
//
assign cust5_op = ex_insn[4:0];
assign cust5_limm = ex_insn[10:5];

//
//
//
assign rfe = (id_branch_op == 3'd6) | 
	     (ex_branch_op == 3'd6);

   

   
//
// Generation of sel_a
//
always @(rf_addrw or id_insn or rfwb_op or wbforw_valid or wb_rfaddrw)
	if ((id_insn[20:16] == rf_addrw) && rfwb_op[0])
		sel_a = 2'd2;
	else if ((id_insn[20:16] == wb_rfaddrw) && wbforw_valid)
		sel_a = 2'd3;
	else
		sel_a = 2'd0;

//
// Generation of sel_b
//
always @(rf_addrw or sel_imm or id_insn or rfwb_op or wbforw_valid or 
	 wb_rfaddrw)
	if (sel_imm)
		sel_b = 2'd1;
	else if ((id_insn[15:11] == rf_addrw) && rfwb_op[0])
		sel_b = 2'd2;
	else if ((id_insn[15:11] == wb_rfaddrw) && wbforw_valid)
		sel_b = 2'd3;
	else
		sel_b = 2'd0;

//
// Decode of multicycle
//
always @(id_insn) begin
  case (id_insn[31:26])		// synopsys parallel_case
    // l.rfe
    6'b001001,
    // l.mfspr
    6'b101101:
      multicycle = 3'd1;	// to read from ITLB/DTLB (sync RAMs)
    // Single cycle instructions
    default: begin
      multicycle = 3'd0;
    end    
  endcase
end // always @ (id_insn)

//
// Encode wait_on signal
//    
always @(id_insn) begin
   case (id_insn[31:26])		// synopsys parallel_case
     6'b111000: 
       wait_on =  ( 1'b0
                     | (id_insn[4:0] == 5'b0_1001 )
		     | (id_insn[4:0] == 5'b0_1010 )
		     | (id_insn[4:0] == 5'b0_0110 )
		     | (id_insn[4:0] == 5'b0_1011 )
		    ) ? 2'd1 : 2'd0;
     6'b101100:       
	 wait_on = 2'd1;
     // l.mtspr
     6'b110000: begin
	wait_on = 2'd3;
     end
     default: begin
	wait_on = 2'd0;
     end
   endcase // case (id_insn[31:26])
end // always @ (id_insn)
   
   
   
   
//
// Register file write address
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		rf_addrw <=  5'd0;
	else if (!ex_freeze & id_freeze)
		rf_addrw <=  5'd00;
	else if (!ex_freeze)
		case (id_insn[31:26])	// synopsys parallel_case
			6'b000001, 6'b010010:
				rf_addrw <=  5'd09;	// link register r9
			default:
				rf_addrw <=  id_insn[25:21];
		endcase
end

//
// rf_addrw in wb stage (used in forwarding logic)
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		wb_rfaddrw <=  5'd0;
	else if (!wb_freeze)
		wb_rfaddrw <=  rf_addrw;
end

//
// Instruction latch in id_insn
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		id_insn <=  {6'b000101, 26'h041_0000};
        else if (id_flushpipe)
                id_insn <=  {6'b000101, 26'h041_0000};        // NOP -> id_insn[16] must be 1
	else if (!id_freeze) begin
		id_insn <=  if_insn;
	end
end

//
// Instruction latch in ex_insn
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		ex_insn <=  {6'b000101, 26'h041_0000};
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		ex_insn <=  {6'b000101, 26'h041_0000};	// NOP -> ex_insn[16] must be 1
	else if (!ex_freeze) begin
		ex_insn <=  id_insn;
	end
end
   
//
// Instruction latch in wb_insn
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		wb_insn <=  {6'b000101, 26'h041_0000};
	// wb_insn should not be changed by exceptions due to correct 
	// recording of display_arch_state in the or1200_monitor! 
	// wb_insn changed by exception is not used elsewhere! 
	else if (!wb_freeze) begin
		wb_insn <=  ex_insn;
	end
end

//
// Decode of sel_imm
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		sel_imm <=  1'b0;
	else if (!id_freeze) begin
	  case (if_insn[31:26])		// synopsys parallel_case

	    // j.jalr
	    6'b010010:
	      sel_imm <=  1'b0;
	    
	    // l.jr
	    6'b010001:
	      sel_imm <=  1'b0;
	    
	    // l.rfe
	    6'b001001:
	      sel_imm <=  1'b0;
	    
	    // l.mfspr
	    6'b101101:
	      sel_imm <=  1'b0;
	    
	    // l.mtspr
	    6'b110000:
	      sel_imm <=  1'b0;
	    
	    // l.sys, l.brk and all three sync insns
	    6'b001000:
	      sel_imm <=  1'b0;
	    
	    // l.mac/l.msb

	    // l.sw
	    6'b110101:
	      sel_imm <=  1'b0;
	    
	    // l.sb
	    6'b110110:
	      sel_imm <=  1'b0;
	    
	    // l.sh
	    6'b110111:
	      sel_imm <=  1'b0;
	    
	    // ALU instructions except the one with immediate
	    6'b111000:
	      sel_imm <=  1'b0;
	    
	    // SFXX instructions
	    6'b111001:
	      sel_imm <=  1'b0;

	    // l.nop
	    6'b000101:
	      sel_imm <=  1'b0;

	    // All instructions with immediates
	    default: begin
	      sel_imm <=  1'b1;
	    end
	    
	  endcase
	  
	end
end

//
// Decode of except_illegal
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		except_illegal <=  1'b0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		except_illegal <=  1'b0;
	else if (!ex_freeze) begin
		case (id_insn[31:26])		// synopsys parallel_case

		6'b000000,
		6'b000001,
		6'b010010,
		6'b010001,
		6'b000011,
		6'b000100,
		6'b001001,
		6'b000110,
		6'b101101,
		6'b001000,
		6'b100001,
		6'b100010,
		6'b100011,
		6'b100100,
		6'b100101,
		6'b100110,
		6'b100111,
		6'b101000,
		6'b101001,
		6'b101010,
		6'b101011,
		6'b101100,
		6'b101110,
		6'b101111,
		6'b110000,
		6'b110101,
		6'b110110,
		6'b110111,
		6'b111001,
	6'b000101:
		except_illegal <=  1'b0;

	6'b111000:
		except_illegal <=  1'b0 




		| ((id_insn[4:0] == 5'b0_1000 ) &
		   (id_insn[9:6] == 4'd3))

		;

		// Illegal and OR1200 unsupported instructions
	default:
		except_illegal <=  1'b1;

	endcase
	end // if (!ex_freeze)
end
   

//
// Decode of alu_op
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		alu_op <=  5'b0_0100;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		alu_op <=  5'b0_0100;
	else if (!ex_freeze) begin
	  case (id_insn[31:26])		// synopsys parallel_case
	    
	    // l.movhi
	    6'b000110:
	      alu_op <=  5'b1_0001 ;
	    
	    // l.addi
	    6'b100111:
	      alu_op <=  5'b0_0000 ;
	    
	    // l.addic
	    6'b101000:
	      alu_op <=  5'b0_0001 ;
	    
	    // l.andi
	    6'b101001:
	      alu_op <=  5'b0_0011 ;
	    
	    // l.ori
	    6'b101010:
	      alu_op <=  5'b0_0100 ;
	    
	    // l.xori
	    6'b101011:
	      alu_op <=  5'b0_0101 ;
	    
	    // l.muli
	    6'b101100:
	      alu_op <=  5'b0_0110 ;
	    
	    // Shift and rotate insns with immediate
	    6'b101110:
	      alu_op <=  5'b0_1000 ;
	    
	    // SFXX insns with immediate
	    6'b101111:
	      alu_op <=  5'b1_0000 ;
	    
	    // ALU instructions except the one with immediate
	    6'b111000:
	      alu_op <=  {1'b0,id_insn[3:0]};
	    
	    // SFXX instructions
	    6'b111001:
	      alu_op <=  5'b1_0000 ;
	    // Default
	    default: begin
	      alu_op <=  5'b0_0100;
	    end
	      
	  endcase
	  
	end
end


//
// Decode of second ALU operation field [9:6]
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		alu_op2 <=  0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
	        alu_op2 <= 0;
   	else if (!ex_freeze) begin
		alu_op2 <=  id_insn[9:6];
	end
end

//
// Decode of spr_read, spr_write
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1)) begin
		spr_read <=  1'b0;
		spr_write <=  1'b0;
	end
	else if (!ex_freeze & id_freeze | ex_flushpipe) begin
		spr_read <=  1'b0;
		spr_write <=  1'b0;
	end
	else if (!ex_freeze) begin
		case (id_insn[31:26])     // synopsys parallel_case

		// l.mfspr
		6'b101101: begin
			spr_read <=  1'b1;
			spr_write <=  1'b0;
		end

		// l.mtspr
		6'b110000: begin
			spr_read <=  1'b0;
			spr_write <=  1'b1;
		end

		// Default
		default: begin
			spr_read <=  1'b0;
			spr_write <=  1'b0;
		end

		endcase
	end
end

//
// Decode of mac_op
//
assign id_mac_op = 3'b000;
assign mac_op = 3'b000;


//
// Decode of rfwb_op
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		rfwb_op <=  4'b0000;
	else  if (!ex_freeze & id_freeze | ex_flushpipe)
		rfwb_op <=  4'b0000;
	else  if (!ex_freeze) begin
		case (id_insn[31:26])		// synopsys parallel_case

		// j.jal
		6'b000001:
			rfwb_op <=  {3'b011, 1'b1};
		  
		// j.jalr
		6'b010010:
			rfwb_op <=  {3'b011, 1'b1};
		  
		// l.movhi
		6'b000110:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// l.mfspr
		6'b101101:
			rfwb_op <=  {3'b010, 1'b1};
		  
		// l.lwz
		6'b100001:
			rfwb_op <=  {3'b001, 1'b1};

		// l.lws
		6'b100010:
			rfwb_op <=  {3'b001, 1'b1};

		// l.lbz
		6'b100011:
			rfwb_op <=  {3'b001, 1'b1};
		  
		// l.lbs
		6'b100100:
			rfwb_op <=  {3'b001, 1'b1};
		  
		// l.lhz
		6'b100101:
			rfwb_op <=  {3'b001, 1'b1};
		  
		// l.lhs
		6'b100110:
			rfwb_op <=  {3'b001, 1'b1};
		  
		// l.addi
		6'b100111:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// l.addic
		6'b101000:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// l.andi
		6'b101001:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// l.ori
		6'b101010:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// l.xori
		6'b101011:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// l.muli
		6'b101100:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// Shift and rotate insns with immediate
		6'b101110:
			rfwb_op <=  {3'b000, 1'b1};
		  
		// ALU instructions except the one with immediate
		6'b111000:
			rfwb_op <=  {3'b000, 1'b1};

		// Instructions w/o register-file write-back
		default: 
			rfwb_op <=  4'b0000;


		endcase
	end
end

//
// Decode of id_branch_op
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		id_branch_op <=  3'd0;
	else if (id_flushpipe)
		id_branch_op <=  3'd0;
	else if (!id_freeze) begin
		case (if_insn[31:26])		// synopsys parallel_case

		// l.j
		6'b000000:
			id_branch_op <=  3'd1;
		  
		// j.jal
		6'b000001:
			id_branch_op <=  3'd1;
		  
		// j.jalr
		6'b010010:
			id_branch_op <=  3'd2;
		  
		// l.jr
		6'b010001:
			id_branch_op <=  3'd2;
		  
		// l.bnf
		6'b000011:
			id_branch_op <=  3'd5;
		  
		// l.bf
		6'b000100:
			id_branch_op <=  3'd4;
		  
		// l.rfe
		6'b001001:
			id_branch_op <=  3'd6;
		  
		// Non branch instructions
		default:
			id_branch_op <=  3'd0;

		endcase
	end
end

//
// Generation of ex_branch_op
//
always @(posedge clk or posedge rst)
	if (rst == (1'b1))
		ex_branch_op <=  3'd0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		ex_branch_op <=  3'd0;		
	else if (!ex_freeze)
		ex_branch_op <=  id_branch_op;

//
// Decode of id_lsu_op
//
always @(id_insn) begin
	case (id_insn[31:26])		// synopsys parallel_case

	// l.lwz
	6'b100001:
		id_lsu_op =  4'b0110;

	// l.lws
	6'b100010:
		id_lsu_op =  4'b0111;

	// l.lbz
	6'b100011:
		id_lsu_op =  4'b0010;

	// l.lbs
	6'b100100:
		id_lsu_op =  4'b0011;

	// l.lhz
	6'b100101:
		id_lsu_op =  4'b0100;

	// l.lhs
	6'b100110:
		id_lsu_op =  4'b0101;

	// l.sw
	6'b110101:
		id_lsu_op =  4'b1110;

	// l.sb
	6'b110110:
		id_lsu_op =  4'b1010;

	// l.sh
	6'b110111:
		id_lsu_op =  4'b1100;

	// Non load/store instructions
	default:
		id_lsu_op =  4'b0000;

	endcase
end

//
// Decode of comp_op
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1)) begin
		comp_op <=  4'd0;
	end else if (!ex_freeze & id_freeze | ex_flushpipe)
		comp_op <=  4'd0;
	else if (!ex_freeze)
		comp_op <=  id_insn[24:21];
end

   assign fpu_op = {8{1'b0}};

   
//
// Decode of l.sys
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		sig_syscall <=  1'b0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		sig_syscall <=  1'b0;
	else if (!ex_freeze) begin
		sig_syscall <=  (id_insn[31:23] == {6'b001000, 3'b000});
	end
end

//
// Decode of l.trap
//
always @(posedge clk or posedge rst) begin
	if (rst == (1'b1))
		sig_trap <=  1'b0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		sig_trap <=  1'b0;
	else if (!ex_freeze) begin
		sig_trap <=  (id_insn[31:23] == {6'b001000, 3'b010})
			| du_hwbkpt;
	end
end

// Decode destination register address for data cache to check if store ops
// are being done from the stack register (r1) or frame pointer register (r2)
   
   assign dc_no_writethrough = 0;
  
   
endmodule