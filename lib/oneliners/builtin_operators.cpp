
// File generated by noodle version U-2022.12#33f3808fcb#221128, Fri Mar 22 18:53:58 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

// File: builtin_operators.cpp
// Test C built-in operators  (//!!except any left undefined)
// (Reference in-out argument avoids additional moves i.c.o. read-modify-write)

// Note `bool' return values and arguments are masked as `int'

#ifndef N // arbitrary value, adapt at will
#define N 13
#endif

extern "C" {

//-- bool

bool biopr_bool_pass(bool c) { return c; }  // no operator, but may involve masking
bool biopr_bool_cmpl(bool c) { return !c; }
bool biopr_bool_land(bool c, bool d) { return c && d; }
bool biopr_bool_lor (bool c, bool d) { return c || d; }

//-- int

void biopr___sint__pl(int& a, int b) { a += b; }
void biopr___sint__mi(int& a, int b) { a -= b; }
void biopr___sint__ml(int& a, int b) { a *= b; }
void biopr___sint__dv(int& a, int b) { a /= b; }
void biopr___sint__md(int& a, int b) { a %= b; }
void biopr___sint__ad(int& a, int b) { a &= b; }
void biopr___sint__or(int& a, int b) { a |= b; }
void biopr___sint__er(int& a, int b) { a ^= b; }
void biopr___sint__ls(int& a, int b) { a <<= b; }
void biopr___sint__rs(int& a, int b) { a >>= b; }
void biopr___sint__co(int& a) { a = ~a; }

void biopr___sint__plN(int& a) { a += N; }
void biopr___sint__miN(int& a) { a -= N; }
void biopr___sint__mlN(int& a) { a *= N; }
void biopr___sint__dvN(int& a) { a /= N; }
void biopr___sint__mdN(int& a) { a %= N; }
void biopr___sint__adN(int& a) { a &= N; }
void biopr___sint__orN(int& a) { a |= N; }
void biopr___sint__erN(int& a) { a ^= N; }
void biopr___sint__lsN(int& a) { a <<= N; }
void biopr___sint__rsN(int& a) { a >>= N; }

void biopr___sint__miR(int& a) { a = N - a; }
void biopr___sint__lsR(int& a) { a = N << a; }
void biopr___sint__rsR(int& a) { a = N >> a; }

bool biopr___sint__lt(int a, int b) { return a < b; }
bool biopr___sint__gt(int a, int b) { return a > b; }
bool biopr___sint__le(int a, int b) { return a <= b; }
bool biopr___sint__ge(int a, int b) { return a >= b; }
bool biopr___sint__eq(int a, int b) { return a == b; }
bool biopr___sint__ne(int a, int b) { return a != b; }

bool biopr___sint__lt0(int a) { return a < 0; }
bool biopr___sint__gt0(int a) { return a > 0; }
bool biopr___sint__le0(int a) { return a <= 0; }
bool biopr___sint__ge0(int a) { return a >= 0; }
bool biopr___sint__eq0(int a) { return a == 0; }
bool biopr___sint__ne0(int a) { return a != 0; }

bool biopr___sint__ltN(int a) { return a < N; }
bool biopr___sint__gtN(int a) { return a > N; }
bool biopr___sint__leN(int a) { return a <= N; }
bool biopr___sint__geN(int a) { return a >= N; }
bool biopr___sint__eqN(int a) { return a == N; }
bool biopr___sint__neN(int a) { return a != N; }

//-- unsigned

void biopr___uint__pl(unsigned& a, unsigned b) { a += b; }
void biopr___uint__mi(unsigned& a, unsigned b) { a -= b; }
void biopr___uint__ml(unsigned& a, unsigned b) { a *= b; }
void biopr___uint__dv(unsigned& a, unsigned b) { a /= b; }
void biopr___uint__md(unsigned& a, unsigned b) { a %= b; }
void biopr___uint__ad(unsigned& a, unsigned b) { a &= b; }
void biopr___uint__or(unsigned& a, unsigned b) { a |= b; }
void biopr___uint__er(unsigned& a, unsigned b) { a ^= b; }
void biopr___uint__ls(unsigned& a, int b) { a <<= b; }
void biopr___uint__rs(unsigned& a, int b) { a >>= b; }
void biopr___uint__co(unsigned& a) { a = ~a; }

void biopr___uint__plN(unsigned& a) { a += N; }
void biopr___uint__miN(unsigned& a) { a -= N; }
void biopr___uint__mlN(unsigned& a) { a *= N; }
void biopr___uint__dvN(unsigned& a) { a /= N; }
void biopr___uint__mdN(unsigned& a) { a %= N; }
void biopr___uint__adN(unsigned& a) { a &= N; }
void biopr___uint__orN(unsigned& a) { a |= N; }
void biopr___uint__erN(unsigned& a) { a ^= N; }
void biopr___uint__lsN(unsigned& a) { a <<= N; }
void biopr___uint__rsN(unsigned& a) { a >>= N; }

void biopr___uint__miR(unsigned& a) { a = N - a; }
void biopr___uint__lsR(unsigned& a) { a = N << a; }
void biopr___uint__rsR(unsigned& a) { a = N >> a; }

bool biopr___uint__lt(unsigned a, unsigned b) { return a < b; }
bool biopr___uint__gt(unsigned a, unsigned b) { return a > b; }
bool biopr___uint__le(unsigned a, unsigned b) { return a <= b; }
bool biopr___uint__ge(unsigned a, unsigned b) { return a >= b; }
bool biopr___uint__eq(unsigned a, unsigned b) { return a == b; }
bool biopr___uint__ne(unsigned a, unsigned b) { return a != b; }

bool biopr___uint__gt0(unsigned a) { return a > 0; }
bool biopr___uint__eq0(unsigned a) { return a == 0; }
bool biopr___uint__ne0(unsigned a) { return a != 0; }

bool biopr___uint__ltN(unsigned a) { return a < N; }
bool biopr___uint__gtN(unsigned a) { return a > N; }
bool biopr___uint__leN(unsigned a) { return a <= N; }
bool biopr___uint__geN(unsigned a) { return a >= N; }
bool biopr___uint__eqN(unsigned a) { return a == N; }
bool biopr___uint__neN(unsigned a) { return a != N; }

//-- long long

void biopr___slonglong__pl(long long& a, long long b) { a += b; }
void biopr___slonglong__mi(long long& a, long long b) { a -= b; }
void biopr___slonglong__ml(long long& a, long long b) { a *= b; }
void biopr___slonglong__dv(long long& a, long long b) { a /= b; }
void biopr___slonglong__md(long long& a, long long b) { a %= b; }
void biopr___slonglong__ad(long long& a, long long b) { a &= b; }
void biopr___slonglong__or(long long& a, long long b) { a |= b; }
void biopr___slonglong__er(long long& a, long long b) { a ^= b; }
void biopr___slonglong__ls(long long& a, int b) { a <<= b; }
void biopr___slonglong__rs(long long& a, int b) { a >>= b; }
void biopr___slonglong__co(long long& a) { a = ~a; }

void biopr___slonglong__plN(long long& a) { a += N; }
void biopr___slonglong__miN(long long& a) { a -= N; }
void biopr___slonglong__mlN(long long& a) { a *= N; }
void biopr___slonglong__dvN(long long& a) { a /= N; }
void biopr___slonglong__mdN(long long& a) { a %= N; }
void biopr___slonglong__adN(long long& a) { a &= N; }
void biopr___slonglong__orN(long long& a) { a |= N; }
void biopr___slonglong__erN(long long& a) { a ^= N; }
void biopr___slonglong__lsN(long long& a) { a <<= N; }
void biopr___slonglong__rsN(long long& a) { a >>= N; }

void biopr___slonglong__miR(long long& a) { a = N - a; }
void biopr___slonglong__lsR(long long& a) { a = N << a; }
void biopr___slonglong__rsR(long long& a) { a = N >> a; }

bool biopr___slonglong__lt(long long a, long long b) { return a < b; }
bool biopr___slonglong__gt(long long a, long long b) { return a > b; }
bool biopr___slonglong__le(long long a, long long b) { return a <= b; }
bool biopr___slonglong__ge(long long a, long long b) { return a >= b; }
bool biopr___slonglong__eq(long long a, long long b) { return a == b; }
bool biopr___slonglong__ne(long long a, long long b) { return a != b; }

bool biopr___slonglong__lt0(long long a) { return a < 0; }
bool biopr___slonglong__gt0(long long a) { return a > 0; }
bool biopr___slonglong__le0(long long a) { return a <= 0; }
bool biopr___slonglong__ge0(long long a) { return a >= 0; }
bool biopr___slonglong__eq0(long long a) { return a == 0; }
bool biopr___slonglong__ne0(long long a) { return a != 0; }

bool biopr___slonglong__ltN(long long a) { return a < N; }
bool biopr___slonglong__gtN(long long a) { return a > N; }
bool biopr___slonglong__leN(long long a) { return a <= N; }
bool biopr___slonglong__geN(long long a) { return a >= N; }
bool biopr___slonglong__eqN(long long a) { return a == N; }
bool biopr___slonglong__neN(long long a) { return a != N; }

//-- unsigned long long

void biopr___ulonglong__pl(unsigned long long& a, unsigned long long b) { a += b; }
void biopr___ulonglong__mi(unsigned long long& a, unsigned long long b) { a -= b; }
void biopr___ulonglong__ml(unsigned long long& a, unsigned long long b) { a *= b; }
void biopr___ulonglong__dv(unsigned long long& a, unsigned long long b) { a /= b; }
void biopr___ulonglong__md(unsigned long long& a, unsigned long long b) { a %= b; }
void biopr___ulonglong__ad(unsigned long long& a, unsigned long long b) { a &= b; }
void biopr___ulonglong__or(unsigned long long& a, unsigned long long b) { a |= b; }
void biopr___ulonglong__er(unsigned long long& a, unsigned long long b) { a ^= b; }
void biopr___ulonglong__ls(unsigned long long& a, int b) { a <<= b; }
void biopr___ulonglong__rs(unsigned long long& a, int b) { a >>= b; }
void biopr___ulonglong__co(unsigned long long& a) { a = ~a; }

void biopr___ulonglong__plN(unsigned long long& a) { a += N; }
void biopr___ulonglong__miN(unsigned long long& a) { a -= N; }
void biopr___ulonglong__mlN(unsigned long long& a) { a *= N; }
void biopr___ulonglong__dvN(unsigned long long& a) { a /= N; }
void biopr___ulonglong__mdN(unsigned long long& a) { a %= N; }
void biopr___ulonglong__adN(unsigned long long& a) { a &= N; }
void biopr___ulonglong__orN(unsigned long long& a) { a |= N; }
void biopr___ulonglong__erN(unsigned long long& a) { a ^= N; }
void biopr___ulonglong__lsN(unsigned long long& a) { a <<= N; }
void biopr___ulonglong__rsN(unsigned long long& a) { a >>= N; }

void biopr___ulonglong__miR(unsigned long long& a) { a = N - a; }
void biopr___ulonglong__lsR(unsigned long long& a) { a = N << a; }
void biopr___ulonglong__rsR(unsigned long long& a) { a = N >> a; }

bool biopr___ulonglong__lt(unsigned long long a, unsigned long long b) { return a < b; }
bool biopr___ulonglong__gt(unsigned long long a, unsigned long long b) { return a > b; }
bool biopr___ulonglong__le(unsigned long long a, unsigned long long b) { return a <= b; }
bool biopr___ulonglong__ge(unsigned long long a, unsigned long long b) { return a >= b; }
bool biopr___ulonglong__eq(unsigned long long a, unsigned long long b) { return a == b; }
bool biopr___ulonglong__ne(unsigned long long a, unsigned long long b) { return a != b; }

bool biopr___ulonglong__gt0(unsigned long long a) { return a > 0; }
bool biopr___ulonglong__eq0(unsigned long long a) { return a == 0; }
bool biopr___ulonglong__ne0(unsigned long long a) { return a != 0; }

bool biopr___ulonglong__ltN(unsigned long long a) { return a < N; }
bool biopr___ulonglong__gtN(unsigned long long a) { return a > N; }
bool biopr___ulonglong__leN(unsigned long long a) { return a <= N; }
bool biopr___ulonglong__geN(unsigned long long a) { return a >= N; }
bool biopr___ulonglong__eqN(unsigned long long a) { return a == N; }
bool biopr___ulonglong__neN(unsigned long long a) { return a != N; }

//-- float

void biopr___ffloat__pl(float& a, float b) { a += b; }
void biopr___ffloat__mi(float& a, float b) { a -= b; }
void biopr___ffloat__ml(float& a, float b) { a *= b; }
void biopr___ffloat__dv(float& a, float b) { a /= b; }

void biopr___ffloat__plN(float& a) { a += N; }
void biopr___ffloat__miN(float& a) { a -= N; }
void biopr___ffloat__mlN(float& a) { a *= N; }
void biopr___ffloat__dvN(float& a) { a /= N; }

void biopr___ffloat__miR(float& a) { a = N - a; }

bool biopr___ffloat__lt(float a, float b) { return a < b; }
bool biopr___ffloat__gt(float a, float b) { return a > b; }
bool biopr___ffloat__le(float a, float b) { return a <= b; }
bool biopr___ffloat__ge(float a, float b) { return a >= b; }
bool biopr___ffloat__eq(float a, float b) { return a == b; }
bool biopr___ffloat__ne(float a, float b) { return a != b; }

bool biopr___ffloat__lt0(float a) { return a < 0; }
bool biopr___ffloat__gt0(float a) { return a > 0; }
bool biopr___ffloat__le0(float a) { return a <= 0; }
bool biopr___ffloat__ge0(float a) { return a >= 0; }
bool biopr___ffloat__eq0(float a) { return a == 0; }
bool biopr___ffloat__ne0(float a) { return a != 0; }

bool biopr___ffloat__ltN(float a) { return a < N; }
bool biopr___ffloat__gtN(float a) { return a > N; }
bool biopr___ffloat__leN(float a) { return a <= N; }
bool biopr___ffloat__geN(float a) { return a >= N; }
bool biopr___ffloat__eqN(float a) { return a == N; }
bool biopr___ffloat__neN(float a) { return a != N; }

//-- double

void biopr___fdouble__pl(double& a, double b) { a += b; }
void biopr___fdouble__mi(double& a, double b) { a -= b; }
void biopr___fdouble__ml(double& a, double b) { a *= b; }
void biopr___fdouble__dv(double& a, double b) { a /= b; }

void biopr___fdouble__plN(double& a) { a += N; }
void biopr___fdouble__miN(double& a) { a -= N; }
void biopr___fdouble__mlN(double& a) { a *= N; }
void biopr___fdouble__dvN(double& a) { a /= N; }

void biopr___fdouble__miR(double& a) { a = N - a; }

bool biopr___fdouble__lt(double a, double b) { return a < b; }
bool biopr___fdouble__gt(double a, double b) { return a > b; }
bool biopr___fdouble__le(double a, double b) { return a <= b; }
bool biopr___fdouble__ge(double a, double b) { return a >= b; }
bool biopr___fdouble__eq(double a, double b) { return a == b; }
bool biopr___fdouble__ne(double a, double b) { return a != b; }

bool biopr___fdouble__lt0(double a) { return a < 0; }
bool biopr___fdouble__gt0(double a) { return a > 0; }
bool biopr___fdouble__le0(double a) { return a <= 0; }
bool biopr___fdouble__ge0(double a) { return a >= 0; }
bool biopr___fdouble__eq0(double a) { return a == 0; }
bool biopr___fdouble__ne0(double a) { return a != 0; }

bool biopr___fdouble__ltN(double a) { return a < N; }
bool biopr___fdouble__gtN(double a) { return a > N; }
bool biopr___fdouble__leN(double a) { return a <= N; }
bool biopr___fdouble__geN(double a) { return a >= N; }
bool biopr___fdouble__eqN(double a) { return a == N; }
bool biopr___fdouble__neN(double a) { return a != N; }


} //extern "C"  (220 functions)
