/*
-- File : jts_ocd_cable.h
--
-- Contents : Physical OCD link - interface with jtag_socket library.
--
-- Copyright (c) 2014-2022 Synopsys, Inc. This Synopsys processor model
-- captures an ASIP Designer Design Technique. The model and all associated
-- documentation are proprietary to Synopsys, Inc. and may only be used
-- pursuant to the terms and conditions of a written license agreement with
-- Synopsys, Inc.  All other use, reproduction, modification, or distribution
-- of the Synopsys processor model or the associated  documentation is
-- strictly prohibited.
*/

#ifndef _jts_ocd_cable_h
#define _jts_ocd_cable_h


#include "ocd_cable.h"
#include "jtag_socket.h"
#include "pdc_opcodes.h"


/*
  This class provides an implementation of the ocd_cable interface for the case
  where the connection is realized via the JTALK program and the JTAG cable.
  This implementation must also be used when the hardware components are
  simulated in RTL.

  The implementation builds on the jts_socket library.
*/


class jts_ocd_cable : public ocd_cable {
public:

    jts_ocd_cable(int coreid, std::string server, int port)
      : ocd_cable(coreid,server,port)
    {

        // JTAG instruction register length (fixed).
        ilen = 16;

        // OCD register lengths (processor dependent).
        dlen[data] = DBG_DATA_REG_WIDTH;
        dlen[addr] = DBG_ADDR_REG_WIDTH;
        dlen[inst] = DBG_INSTR_REG_WIDTH;
        dlen[stat] = DBG_STATUS_REG_WIDTH;
        dlen[ctxt] = DBG_CONTEXT_REG_WIDTH;

        // OCD register JTAG_IREG codes (dependent on core id).
        int cid = coreid << 11;
        dcode[data] = cid | DBG_DATA_REG_INSTR;
        dcode[addr] = cid | DBG_ADDR_REG_INSTR;
        dcode[inst] = cid | DBG_INSTR_REG_INSTR;
        dcode[stat] = cid | DBG_STATUS_REG_INSTR;
        dcode[ctxt] = cid | DBG_CONTEXT_REG_INSTR;
    }

    ~jts_ocd_cable() {}

    int open() override {
        jts_cmdbuf_new_command_sequence(&buffer);  // clear buffer
        return jts_connect(server.c_str(), port);
    }

    int close() override {
        return jts_send_quit();
    }

    int add_iwrite(long long val) override {
        return jts_cmdbuf_add_iwrite(&buffer,ilen,val);
    }

    int add_iwrite_wait(long long val, int N) {
        /* After an I-write no data register is selected, so a harmless data
         * scan can be added to insert extra delay in the command buffer. This
         * can be useful after a load/store command, to give the processor
         * extra time to complete the access of a slow peripheral device. The
         * wait time is 20*N JTAG clock cycles (when N ==0 there is already a
         * delay of 20 JTAG clock cycles between successive JTAG commands).
         */
        return jts_cmdbuf_add_iwrite(&buffer,ilen,val,N);
    }

    int add_dwrite(reg_type r, const DataType& val) override {
        return jts_cmdbuf_add_dwrite(&buffer,ilen,dcode[r],dlen[r],val);
    }

    int add_dread(reg_type r) override {
        return jts_cmdbuf_add_dread(&buffer,ilen,dcode[r],dlen[r]);
    }

    int add_dwrite_dread(reg_type r, const DataType& val) override {
        return jts_cmdbuf_add_dwrite_dread(&buffer,ilen,dcode[r],dlen[r],val);
    }

    int send_and_receive() override {
        /* Include for debugging problems
           if (verbose)  {
           std::cerr << std::endl;
           jts_cmdbuf_set_length(&buffer);
           jts_cmdbuf_print(stderr,&buffer);
           }
        */
        if (jts_cmdbuf_send(&buffer) == JTS_ERR_SEND) {
          throw std::runtime_error("socket send failed");
        }
        if (jts_expect_reply(&answer) == JTS_ERR_RECV) {
          throw std::runtime_error("socket receive failed");
        }
        jts_cmdbuf_new_command_sequence(&buffer);
        if (answer.kind != JTS_Server_message::answer)
            answer.buf_ptr = 0;
        return 0;
    }

    int get_next_data(DataType& val) override {
        return jts_next_data(&answer,val);
    }

    bool buffer_overflow_imminent() override {
        return jts_cmdbuf_length(&buffer) > buffer_limit;
    }

    bool buffer_is_empty() override {
        return jts_cmdbuf_is_empty(&buffer) != 0;
    }

    void set_verbose(int v) override { jts_verbose = v > 0; }


private:
    const static int buffer_limit = 4096;

    int ilen;
    int dlen[5];
    int dcode[5];

    JTS_Client_message buffer;   // jts_socket library buffers are used.
    JTS_Server_message answer;
};

#endif
