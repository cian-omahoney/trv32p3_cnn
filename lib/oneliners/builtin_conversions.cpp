
// File generated by noodle version U-2022.12#33f3808fcb#221128, Thu Feb 29 17:31:35 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

// File: builtin_conversions.cpp
// Test C built-in conversions  (except any left undefined)

extern "C" {


//-- signed char

signed char         bicnv___schar___uchar         (unsigned char       a) { return a; }
signed char         bicnv___schar___sshort        (short               a) { return a; }
signed char         bicnv___schar___ushort        (unsigned short      a) { return a; }
signed char         bicnv___schar___sint          (int                 a) { return a; }
signed char         bicnv___schar___uint          (unsigned            a) { return a; }
signed char         bicnv___schar___slonglong     (long long           a) { return a; }
signed char         bicnv___schar___ulonglong     (unsigned long long  a) { return a; }
signed char         bicnv___schar___ffloat        (float               a) { return a; }
signed char         bicnv___schar___fdouble       (double              a) { return a; }

//-- unsigned char

unsigned char       bicnv___uchar___schar         (signed char         a) { return a; }
unsigned char       bicnv___uchar___sshort        (short               a) { return a; }
unsigned char       bicnv___uchar___ushort        (unsigned short      a) { return a; }
unsigned char       bicnv___uchar___sint          (int                 a) { return a; }
unsigned char       bicnv___uchar___uint          (unsigned            a) { return a; }
unsigned char       bicnv___uchar___slonglong     (long long           a) { return a; }
unsigned char       bicnv___uchar___ulonglong     (unsigned long long  a) { return a; }
unsigned char       bicnv___uchar___ffloat        (float               a) { return a; }
unsigned char       bicnv___uchar___fdouble       (double              a) { return a; }

//-- short

short               bicnv___sshort___schar        (signed char         a) { return a; }
short               bicnv___sshort___uchar        (unsigned char       a) { return a; }
short               bicnv___sshort___ushort       (unsigned short      a) { return a; }
short               bicnv___sshort___sint         (int                 a) { return a; }
short               bicnv___sshort___uint         (unsigned            a) { return a; }
short               bicnv___sshort___slonglong    (long long           a) { return a; }
short               bicnv___sshort___ulonglong    (unsigned long long  a) { return a; }
short               bicnv___sshort___ffloat       (float               a) { return a; }
short               bicnv___sshort___fdouble      (double              a) { return a; }

//-- unsigned short

unsigned short      bicnv___ushort___schar        (signed char         a) { return a; }
unsigned short      bicnv___ushort___uchar        (unsigned char       a) { return a; }
unsigned short      bicnv___ushort___sshort       (short               a) { return a; }
unsigned short      bicnv___ushort___sint         (int                 a) { return a; }
unsigned short      bicnv___ushort___uint         (unsigned            a) { return a; }
unsigned short      bicnv___ushort___slonglong    (long long           a) { return a; }
unsigned short      bicnv___ushort___ulonglong    (unsigned long long  a) { return a; }
unsigned short      bicnv___ushort___ffloat       (float               a) { return a; }
unsigned short      bicnv___ushort___fdouble      (double              a) { return a; }

//-- int

int                 bicnv___sint___schar          (signed char         a) { return a; }
int                 bicnv___sint___uchar          (unsigned char       a) { return a; }
int                 bicnv___sint___sshort         (short               a) { return a; }
int                 bicnv___sint___ushort         (unsigned short      a) { return a; }
int                 bicnv___sint___uint           (unsigned            a) { return a; }
int                 bicnv___sint___slonglong      (long long           a) { return a; }
int                 bicnv___sint___ulonglong      (unsigned long long  a) { return a; }
int                 bicnv___sint___ffloat         (float               a) { return a; }
int                 bicnv___sint___fdouble        (double              a) { return a; }

//-- unsigned

unsigned            bicnv___uint___schar          (signed char         a) { return a; }
unsigned            bicnv___uint___uchar          (unsigned char       a) { return a; }
unsigned            bicnv___uint___sshort         (short               a) { return a; }
unsigned            bicnv___uint___ushort         (unsigned short      a) { return a; }
unsigned            bicnv___uint___sint           (int                 a) { return a; }
unsigned            bicnv___uint___slonglong      (long long           a) { return a; }
unsigned            bicnv___uint___ulonglong      (unsigned long long  a) { return a; }
unsigned            bicnv___uint___ffloat         (float               a) { return a; }
unsigned            bicnv___uint___fdouble        (double              a) { return a; }

//-- long long

long long           bicnv___slonglong___schar     (signed char         a) { return a; }
long long           bicnv___slonglong___uchar     (unsigned char       a) { return a; }
long long           bicnv___slonglong___sshort    (short               a) { return a; }
long long           bicnv___slonglong___ushort    (unsigned short      a) { return a; }
long long           bicnv___slonglong___sint      (int                 a) { return a; }
long long           bicnv___slonglong___uint      (unsigned            a) { return a; }
long long           bicnv___slonglong___ulonglong (unsigned long long  a) { return a; }
long long           bicnv___slonglong___ffloat    (float               a) { return a; }
long long           bicnv___slonglong___fdouble   (double              a) { return a; }

//-- unsigned long long

unsigned long long  bicnv___ulonglong___schar     (signed char         a) { return a; }
unsigned long long  bicnv___ulonglong___uchar     (unsigned char       a) { return a; }
unsigned long long  bicnv___ulonglong___sshort    (short               a) { return a; }
unsigned long long  bicnv___ulonglong___ushort    (unsigned short      a) { return a; }
unsigned long long  bicnv___ulonglong___sint      (int                 a) { return a; }
unsigned long long  bicnv___ulonglong___uint      (unsigned            a) { return a; }
unsigned long long  bicnv___ulonglong___slonglong (long long           a) { return a; }
unsigned long long  bicnv___ulonglong___ffloat    (float               a) { return a; }
unsigned long long  bicnv___ulonglong___fdouble   (double              a) { return a; }

//-- float

float               bicnv___ffloat___schar        (signed char         a) { return a; }
float               bicnv___ffloat___uchar        (unsigned char       a) { return a; }
float               bicnv___ffloat___sshort       (short               a) { return a; }
float               bicnv___ffloat___ushort       (unsigned short      a) { return a; }
float               bicnv___ffloat___sint         (int                 a) { return a; }
float               bicnv___ffloat___uint         (unsigned            a) { return a; }
float               bicnv___ffloat___slonglong    (long long           a) { return a; }
float               bicnv___ffloat___ulonglong    (unsigned long long  a) { return a; }
float               bicnv___ffloat___fdouble      (double              a) { return a; }

//-- double

double              bicnv___fdouble___schar       (signed char         a) { return a; }
double              bicnv___fdouble___uchar       (unsigned char       a) { return a; }
double              bicnv___fdouble___sshort      (short               a) { return a; }
double              bicnv___fdouble___ushort      (unsigned short      a) { return a; }
double              bicnv___fdouble___sint        (int                 a) { return a; }
double              bicnv___fdouble___uint        (unsigned            a) { return a; }
double              bicnv___fdouble___slonglong   (long long           a) { return a; }
double              bicnv___fdouble___ulonglong   (unsigned long long  a) { return a; }
double              bicnv___fdouble___ffloat      (float               a) { return a; }

} //extern "C"  (90 functions)
