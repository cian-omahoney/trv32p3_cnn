/*
-- File : trv32p3_cnn_define.h
--
-- Contents : Common model configuration flags.
--
-- Copyright (c) 2019-2020 Synopsys, Inc. This Synopsys processor model
-- captures an ASIP Designer Design Technique. The model and all associated
-- documentation are proprietary to Synopsys, Inc. and may only be used
-- pursuant to the terms and conditions of a written license agreement with
-- Synopsys, Inc.  All other use, reproduction, modification, or distribution
-- of the Synopsys processor model or the associated  documentation is
-- strictly prohibited.
*/

// External Memories: HDL, ISS, Linker.
// Size = number of words
//  * ePM: 32 bits per word
//  * eDM: 32 bits per word
#define MEM_ePM_SZ_NBIT 16
#define MEM_eDM_SZ_NBIT 14

// Note: this header file is included almost everywhere, e.g. in the processing
// of nML, PDG, C/C++, BCF, ... files. Be careful which preprocessor macros
// you define here, since name clashes can happen.
