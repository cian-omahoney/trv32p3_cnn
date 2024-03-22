
// File generated by pdg version U-2022.12#33f3808fcb#221128
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// pdg -P -Iisg +wisg -D__tct_patch__=0 -D__checkers__ trv32p3_cnn

#ifndef TRV32P3_CNN_INLINE_PRIMITIVES_H
#define TRV32P3_CNN_INLINE_PRIMITIVES_H

#ifdef __checkers__
#include "Mdl_trv32p3_cnn.h"

#include "checkers_errors.h"
#endif // __checkers__

#include <sstream>

#include <iostream>
#include <cstdlib>
#ifndef PDG_NATIVE_HANDLE_ERR
#define PDG_NATIVE_HANDLE_ERR(msg, loc) \
  std::cerr << "An error occurred: " << msg << " at: " << loc << '\n'; \
  std::cerr << "Exiting..\n"; \
  exit(1);
#endif

#ifndef PDG_NATIVE_HANDLE_WRN
#define PDG_NATIVE_HANDLE_WRN(msg, loc) \
  std::cerr << "Warning: " << msg << " at: " << loc << '\n';
#endif

#ifdef __GNUC__
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wparentheses"
#endif

namespace trv32p3_cnn_primitive {

    const int controller_module_id = 0;
    const int div_module_id = 1;
    const int dm_merge_module_id = 2;
    const int dm_wbb_module_id = 3;

    inline const trv32p3_cnn_primitive::v22w32 getexpRes() {
        static const unsigned long long a[] = { 12884901889ull, 85899345927ull, 635655159863ull, 4711579124115ull, 34802120002469ull, 257156871902730ull, 1900149366488003ull, 14040321106270636ull, 103744733180303199ull, 766575645775488065ull, 5664270447465400459ull };
        return VBitVector<trv32p3_cnn_primitive::w32, 22>(a);
    }

    inline trv32p3_cnn_primitive::w32 add(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return (a.val + b.val);
    }

    inline trv32p3_cnn_primitive::w32 sub(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return (a.val - b.val);
    }

    inline trv32p3_cnn_primitive::w32 slt(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return trv32p3_cnn_primitive::w32((a.val < b.val));
    }

    inline trv32p3_cnn_primitive::w32 sltu(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return trv32p3_cnn_primitive::w32((VBit<32, false>(a.val) < VBit<32, false>(b.val)));
    }

    inline trv32p3_cnn_primitive::w32 seq0(trv32p3_cnn_primitive::w32 a) {
        return trv32p3_cnn_primitive::w32((a.val == VBit<32, true>(0x0)));
    }

    inline trv32p3_cnn_primitive::w32 sne0(trv32p3_cnn_primitive::w32 a) {
        return trv32p3_cnn_primitive::w32((a.val != VBit<32, true>(0x0)));
    }

    inline trv32p3_cnn_primitive::w32 mul(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return trv32p3_cnn_primitive::w32((a.val * b.val));
    }

    inline trv32p3_cnn_primitive::w32 mulh(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        VBit<64, true> p = (a.val * b.val);
        return VBit<32, true>(p.extract<0x3Fu, 0x20u>());
    }

    inline trv32p3_cnn_primitive::w32 mulhsu(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        VBit<64, true> p = (a.val * VBit<32, false>(b.val));
        return VBit<32, true>(p.extract<0x3Fu, 0x20u>());
    }

    inline trv32p3_cnn_primitive::w32 mulhu(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        VBit<64, true> p = VBit<64, true>((VBit<32, false>(a.val) * VBit<32, false>(b.val)));
        return VBit<32, true>(p.extract<0x3Fu, 0x20u>());
    }

    inline trv32p3_cnn_primitive::w32 band(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return (a.val & b.val);
    }

    inline trv32p3_cnn_primitive::w32 bor(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return (a.val | b.val);
    }

    inline trv32p3_cnn_primitive::w32 bxor(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return (a.val ^ b.val);
    }

    inline bool eq(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return (a.val == b.val);
    }

    inline bool ne(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return (a.val != b.val);
    }

    inline bool lt(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return (a.val < b.val);
    }

    inline bool ge(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return (a.val >= b.val);
    }

    inline bool ltu(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return (VBit<32, false>(a.val) < VBit<32, false>(b.val));
    }

    inline bool geu(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return (VBit<32, false>(a.val) >= VBit<32, false>(b.val));
    }

    inline trv32p3_cnn_primitive::w32 sra(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return (a.val >> VBit<5, false>(VBit<5, true>(b.val.extract<0x4u, 0x0u>())));
    }

    inline trv32p3_cnn_primitive::w32 sll(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return trv32p3_cnn_primitive::w32((VBit<32, false>(a.val) << VBit<5, false>(VBit<5, true>(b.val.extract<0x4u, 0x0u>()))));
    }

    inline trv32p3_cnn_primitive::w32 srl(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        return trv32p3_cnn_primitive::w32((VBit<32, false>(a.val) >> VBit<5, false>(VBit<5, true>(b.val.extract<0x4u, 0x0u>()))));
    }

    inline trv32p3_cnn_primitive::w32 sext(trv32p3_cnn_primitive::w08 a) {
        return trv32p3_cnn_primitive::w32(a.val);
    }

    inline trv32p3_cnn_primitive::w32 zext(trv32p3_cnn_primitive::w08 a) {
        return trv32p3_cnn_primitive::w32(VBit<8, false>(a.val));
    }

    inline trv32p3_cnn_primitive::w32 sext(trv32p3_cnn_primitive::w16 a) {
        return trv32p3_cnn_primitive::w32(a.val);
    }

    inline trv32p3_cnn_primitive::w32 zext(trv32p3_cnn_primitive::w16 a) {
        return trv32p3_cnn_primitive::w32(VBit<16, false>(a.val));
    }

    inline void nop() {
    }

    inline void mul_hw(trv32p3_cnn_primitive::w32 opa, trv32p3_cnn_primitive::w32 opb, trv32p3_cnn_primitive::t2u mode, trv32p3_cnn_primitive::w32& pl, trv32p3_cnn_primitive::w32& ph) {
        VBit<33, true> a = VBit<33, true>(::concat((VBit<1, false>(mode.val.extract(0x1u)) & VBit<1, false>(opa.val.extract(0x1Fu))), VBit<32, false>(opa.val)));
        VBit<33, true> b = VBit<33, true>(::concat((VBit<1, false>(mode.val.extract(0x0u)) & VBit<1, false>(opb.val.extract(0x1Fu))), VBit<32, false>(opb.val)));
        VBit<66, true> r = (a * b);
        pl = VBit<32, true>(r.extract<0x1Fu, 0x0u>());
        ph = VBit<32, true>(r.extract<0x3Fu, 0x20u>());
    }

    inline trv32p3_cnn_primitive::w32 divs(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        if ((b.val == VBit<32, true>(0x0))) {
            return VBit<32, true>(-0x1);
        } else {
            return (a.val / b.val);
        }
    }

    inline trv32p3_cnn_primitive::w32 rems(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        if ((b.val == VBit<32, true>(0x0))) {
            return a;
        } else {
            return (a.val % b.val);
        }
    }

    inline trv32p3_cnn_primitive::w32 divu(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        if ((b.val == VBit<32, true>(0x0))) {
            return VBit<32, true>(-0x1);
        } else {
            return trv32p3_cnn_primitive::w32((VBit<32, false>(a.val) / VBit<32, false>(b.val)));
        }
    }

    inline trv32p3_cnn_primitive::w32 remu(trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        if ((b.val == VBit<32, true>(0x0))) {
            return a;
        } else {
            return trv32p3_cnn_primitive::w32((VBit<32, false>(a.val) % VBit<32, false>(b.val)));
        }
    }

    inline VBit<64, false> div_step(VBit<64, false> pa, VBit<32, false> b) {
        VBit<64, false> new_pa = (pa << VBit<1, false>(0x1u));
        VBit<33, false> diff = (VBit<33, false>(VBit<32, false>(new_pa.extract<0x3Fu, 0x20u>())) - VBit<33, false>(b));
        if ((diff.extract(0x20u) == VBit<1, false>(0x0u))) {
            new_pa.deposit(VBit<32, false>(diff), 0x3Fu, 0x20u);
            new_pa.deposit(VBit<1, false>(0x1u), 0x0u);
        }
        return new_pa;
    }

    inline trv32p3_cnn_primitive::w32 INT32_SATURATION(VBit<64, true> fullResult) {
        VBit<32, true> saturatedResult{VBitZeroInitializeTag{}};
        if ((fullResult > VBit<64, true>(0x7FFFFFFF))) {
            saturatedResult = VBit<32, true>(0x7FFFFFFF);
        } else if ((fullResult < VBit<64, true>(-0x80000000ll))) {
            saturatedResult = VBit<32, true>(-0x80000000ll);
        } else {
            saturatedResult = VBit<32, true>(fullResult.extract<0x1Fu, 0x0u>());
        }
        return saturatedResult;
    }

    inline trv32p3_cnn_primitive::w32 mac(trv32p3_cnn_primitive::w32 c, trv32p3_cnn_primitive::w32 a, trv32p3_cnn_primitive::w32 b) {
        VBit<32, true> multResult{VBitZeroInitializeTag{}};
        VBit<32, true> result{VBitZeroInitializeTag{}};
        multResult = INT32_SATURATION((a.val * b.val)).val;
        result = INT32_SATURATION(VBit<64, true>((c.val + multResult))).val;
        return result;
    }

#ifdef __checkers__
    class div {
    public:
        div(trv32p3_cnn* p) : mdl(p) {}
        void main();

#ifdef __checkers__
        void state_to_core() {
        }

#endif // __checkers__

#ifdef __checkers__
        void div_adr_writer() {
            mdl->div_adr.write(trv32p3_cnn_primitive::t5unz(mdl->div__Q_addr_reg.pdgValue()));
        }

#endif // __checkers__

#ifdef __checkers__
        void div_wnc_writer() {
            mdl->div_wnc.write(trv32p3_cnn_primitive::t1u((mdl->div__cnt.pdgValue() == VBit<6, false>(0x2u))));
        }

#endif // __checkers__

#ifdef __checkers__
        void div_bsy_writer() {
            mdl->div_bsy.write(trv32p3_cnn_primitive::t1u((mdl->div__cnt.pdgValue() != VBit<6, false>(0x0u))));
        }

#endif // __checkers__

#ifdef __checkers__
        void update_status() {
            mdl->div__B.update_sync();
            mdl->div__PA.update_sync();
            mdl->div__Q_addr_reg.update_sync();
            mdl->div__cnt.update_sync();
            mdl->div__is_div.update_sync();
            mdl->div__is_neg.update_sync();
            mdl->X.update_sync();
        }

#endif // __checkers__

#ifdef __checkers__
        void clear_update() {
            mdl->div__B.clear_update_sync();
            mdl->div__PA.clear_update_sync();
            mdl->div__Q_addr_reg.clear_update_sync();
            mdl->div__cnt.clear_update_sync();
            mdl->div__is_div.clear_update_sync();
            mdl->div__is_neg.clear_update_sync();
            mdl->X.clear_update_sync();
        }

#endif // __checkers__

    private:
        trv32p3_cnn* mdl;
    };

    class dm_merge {
    public:
        dm_merge(trv32p3_cnn* p) : mdl(p) {}

#ifdef __checkers__
        void process_result() {
            trv32p3_cnn_primitive::u08 b0 = mdl->wdm_rd.read().elem((mdl->dm_merge__col_ff.pdgValue()).to_unsigned()).val;
            trv32p3_cnn_primitive::u08 b1 = mdl->wdm_rd.read().elem((::concat(VBit<1, false>(mdl->dm_merge__col_ff.pdgValue().extract(0x1u)), VBit<1, false>(0x1u))).to_unsigned()).val;
            mdl->dmw_rd.write(trv32p3_cnn_primitive::w32(::concat(mdl->wdm_rd.read().elem(0x3u).val, mdl->wdm_rd.read().elem(0x2u).val, b1.val, b0.val)));
            mdl->dmh_rd.write(trv32p3_cnn_primitive::w16(::concat(b1.val, b0.val)));
            mdl->dmb_rd.write(trv32p3_cnn_primitive::w08(b0.val));
        }

#endif // __checkers__

#ifdef __checkers__
        void process_request() {
            trv32p3_cnn_primitive::addr row = trv32p3_cnn_primitive::addr(VBit<30, false>(mdl->dm_addr.read().val.extract<0x1Fu, 0x2u>())).val;
            VBit<2, false> col = VBit<2, false>(mdl->dm_addr.read().val.extract<0x1u, 0x0u>());
            mdl->wdm_addr.write(row);
            mdl->dm_merge__col_ff.assign(2, col);
            VBit<4, false> t1 = VBit<4, false>(0x0u);
            if (mdl->dmw_st.read()) {
                t1 = VBit<4, false>(0xFu);
            } else if (mdl->dmh_st.read()) {
                t1 = (VBit<4, false>(0x3u) << ::concat(VBit<1, false>(col.extract(0x1u)), VBit<1, false>(0x0u)));
            } else if (mdl->dmb_st.read()) {
                t1 = (VBit<4, false>(0x1u) << col);
            }
            mdl->wdm_st.write(VBitVector<VBit<1, false>, 4>(t1));
            if (mdl->dm_merge__st_ff.pdgValue().extract(0x2u)) {
                mdl->wdm_wr.write(VBitVector<trv32p3_cnn_primitive::u08, 4>(mdl->dmw_wr.read().val));
            } else if (mdl->dm_merge__st_ff.pdgValue().extract(0x1u)) {
                mdl->wdm_wr.write(VBitVector<trv32p3_cnn_primitive::u08, 4>(::concat(mdl->dmh_wr.read().val, mdl->dmh_wr.read().val)));
            } else if (mdl->dm_merge__st_ff.pdgValue().extract(0x0u)) {
                mdl->wdm_wr.write(VBitVector<trv32p3_cnn_primitive::u08, 4>(::concat(mdl->dmb_wr.read().val, mdl->dmb_wr.read().val, mdl->dmb_wr.read().val, mdl->dmb_wr.read().val)));
            }
            mdl->dm_merge__st_ff.assign(2, ::concat(VBit<1, false>(mdl->dmw_st.read()), VBit<1, false>(mdl->dmh_st.read()), VBit<1, false>(mdl->dmb_st.read())));
        }

#endif // __checkers__

#ifdef __checkers__
        void wdm_ld_writer() {
            mdl->wdm_ld.write(((mdl->dmw_ld.read() | mdl->dmh_ld.read()) | mdl->dmb_ld.read()));
        }

#endif // __checkers__

#ifdef __checkers__
        void update_status() {
            mdl->dm_merge__col_ff.update();
            mdl->dm_merge__st_ff.update();
        }

#endif // __checkers__

#ifdef __checkers__
        void clear_update() {
            mdl->dm_merge__col_ff.clear_update();
            mdl->dm_merge__st_ff.clear_update();
        }

#endif // __checkers__

        void dbg_access_DMb(AddressType a, trv32p3_cnn_primitive::w08& val, bool read) {
            trv32p3_cnn_primitive::addr row = trv32p3_cnn_primitive::addr(VBit<30, false>(VBit<64, false>(a).extract<0x1Fu, 0x2u>())).val;
            VBit<2, false> col = VBit<2, false>(VBit<64, false>(a).extract<0x1u, 0x0u>());
            trv32p3_cnn_primitive::u08 v = trv32p3_cnn_primitive::u08(val.val).val;
            dbg_access_wDM((row).val.to_unsigned(), (col).to_unsigned(), v, read);
            val = trv32p3_cnn_primitive::w08(v.val).val;
        }

        void dbg_access_wDM(AddressType dbg_addr, VectorIndexType dbg_elem, trv32p3_cnn_primitive::u08& dbg_val, bool dbg_read);

    private:
        trv32p3_cnn* mdl;
    };

    class dm_wbb {
    public:
        dm_wbb(trv32p3_cnn* p) : mdl(p) {}

#ifdef __checkers__
        void process_result() {
            bool byp = ((mdl->dm_wbb__edm_wbb_ff.pdgValue()).to_bool() && (mdl->dm_wbb__edm_addr_match_ff.pdgValue()).to_bool());
            VBit<4, false> sel = (mdl->dm_wbb__edm_strb_ff.pdgValue() & ::concat(VBit<1, false>(byp), VBit<1, false>(byp), VBit<1, false>(byp), VBit<1, false>(byp)));
            trv32p3_cnn_primitive::u08 t{VBitZeroInitializeTag{}};
            if ((sel.extract(0x3u) == VBit<1, false>(0x0u))) {
                t = mdl->edm_rd.read().elem(0x3u).val;
            } else {
                t = mdl->dm_wbb__edm_data_ff.pdgValue().elem(0x3u).val;
            }
            trv32p3_cnn_primitive::u08 t_0{VBitZeroInitializeTag{}};
            if ((sel.extract(0x2u) == VBit<1, false>(0x0u))) {
                t_0 = mdl->edm_rd.read().elem(0x2u).val;
            } else {
                t_0 = mdl->dm_wbb__edm_data_ff.pdgValue().elem(0x2u).val;
            }
            trv32p3_cnn_primitive::u08 t_1{VBitZeroInitializeTag{}};
            if ((sel.extract(0x1u) == VBit<1, false>(0x0u))) {
                t_1 = mdl->edm_rd.read().elem(0x1u).val;
            } else {
                t_1 = mdl->dm_wbb__edm_data_ff.pdgValue().elem(0x1u).val;
            }
            trv32p3_cnn_primitive::u08 t_2{VBitZeroInitializeTag{}};
            if ((sel.extract(0x0u) == VBit<1, false>(0x0u))) {
                t_2 = mdl->edm_rd.read().elem(0x0u).val;
            } else {
                t_2 = mdl->dm_wbb__edm_data_ff.pdgValue().elem(0x0u).val;
            }
            mdl->wdm_rd.write(VBitVector<trv32p3_cnn_primitive::u08, 4>(::concat(t.val, t_0.val, t_1.val, t_2.val)));
        }

#endif // __checkers__

        void process_request();

#ifdef __checkers__
        void edm_ld_writer() {
            mdl->edm_ld.write(mdl->wdm_ld.read());
        }

#endif // __checkers__

#ifdef __checkers__
        void update_status() {
            mdl->dm_wbb__edm_addr_ff.update();
            mdl->dm_wbb__edm_addr_match_ff.update();
            mdl->dm_wbb__edm_data_ff.update();
            mdl->dm_wbb__edm_st_ff.update();
            mdl->dm_wbb__edm_strb_ff.update();
            mdl->dm_wbb__edm_wbb_ff.update();
        }

#endif // __checkers__

#ifdef __checkers__
        void clear_update() {
            mdl->dm_wbb__edm_addr_ff.clear_update();
            mdl->dm_wbb__edm_addr_match_ff.clear_update();
            mdl->dm_wbb__edm_data_ff.clear_update();
            mdl->dm_wbb__edm_st_ff.clear_update();
            mdl->dm_wbb__edm_strb_ff.clear_update();
            mdl->dm_wbb__edm_wbb_ff.clear_update();
        }

#endif // __checkers__

        void dbg_access_wDM(AddressType a, VectorIndexType elem, trv32p3_cnn_primitive::u08& val, bool read) {
            VBit<1, false> val_edm_wbb_ff{VBitZeroInitializeTag{}};
            dbg_access_edm_wbb_ff(val_edm_wbb_ff, 0x1u);
            trv32p3_cnn_primitive::addr val_edm_addr_ff{VBitZeroInitializeTag{}};
            dbg_access_edm_addr_ff(val_edm_addr_ff, 0x1u);
            if (((val_edm_wbb_ff).to_bool() && (VBit<64, false>(val_edm_addr_ff.val) == a))) {
                VBitVector<trv32p3_cnn_primitive::u08, 4> tmp_wbb{VBitZeroInitializeTag{}};
                dbg_access_edm_data_ff(tmp_wbb, bool(0x1u));
                VBit<4, false> val_edm_strb_ff{VBitZeroInitializeTag{}};
                dbg_access_edm_strb_ff(val_edm_strb_ff, 0x1u);
                if ((!read && val_edm_strb_ff.extract(elem))) {
                    tmp_wbb.elem(elem) = val.val;
                    dbg_access_edm_data_ff(tmp_wbb, bool(0x0u));
                }
                dbg_access_eDM(a, elem, val, read);
                VBit<4, false> val_edm_strb_ff_0{VBitZeroInitializeTag{}};
                dbg_access_edm_strb_ff(val_edm_strb_ff_0, 0x1u);
                trv32p3_cnn_primitive::u08 t{VBitZeroInitializeTag{}};
                if (val_edm_strb_ff_0.extract(elem)) {
                    t = tmp_wbb.elem(elem).val;
                } else {
                    t = val.val;
                }
                val = t.val;
            } else {
                dbg_access_eDM(a, elem, val, read);
            }
        }

        void dbg_access_edm_data_ff(VBitVector<trv32p3_cnn_primitive::u08, 4>& dbg_val, bool dbg_read) {
            mdl->dm_wbb__edm_data_ff.dbg_access(dbg_val, dbg_read);
        }

        void dbg_access_eDM(AddressType dbg_addr, VectorIndexType dbg_elem, trv32p3_cnn_primitive::u08& dbg_val, bool dbg_read);

        void dbg_access_edm_wbb_ff(VBit<1, false>& dbg_val, bool dbg_read) {
            mdl->dm_wbb__edm_wbb_ff.dbg_access(dbg_val, dbg_read);
        }

        void dbg_access_edm_addr_ff(trv32p3_cnn_primitive::addr& dbg_val, bool dbg_read) {
            mdl->dm_wbb__edm_addr_ff.dbg_access(dbg_val, dbg_read);
        }

        void dbg_access_edm_strb_ff(VBit<4, false>& dbg_val, bool dbg_read) {
            mdl->dm_wbb__edm_strb_ff.dbg_access(dbg_val, dbg_read);
        }

    private:
        trv32p3_cnn* mdl;
    };

#endif // __checkers__

} // namespace trv32p3_cnn_primitive
#ifdef __GNUC__
#pragma GCC diagnostic pop
#endif

#endif
