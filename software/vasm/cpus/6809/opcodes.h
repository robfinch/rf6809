  "aba",   {INH            }, {0x1807,    NA,    NA,    NA, HC12},
  "abx",   {INH            }, {  0x3a,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "abx",   {INH            }, {0x1ae5,    NA,    NA,    NA, HC12},
  "aby",   {INH            }, {0x19ed,    NA,    NA,    NA, HC12},
  "adca",  {AL1            }, {  0x89,  0x99,  0xa9,  0xb9, M6809|HD6309|HC12|RF6809X12},
  "adcb",  {AL1            }, {  0xc9,  0xd9,  0xe9,  0xf9, M6809|HD6309|HC12|RF6809X12},
  "adcd",  {AL2            }, {0x1089,0x1099,0x10a9,0x10b9, HD6309},
  "adcr",  {TFR,TFR        }, {0x1031,    NA,    NA,    NA, HD6309},
  "adda",  {AL1            }, {  0x8b,  0x9b,  0xab,  0xbb, M6809|HD6309|HC12|RF6809X12},
  "addb",  {AL1            }, {  0xcb,  0xdb,  0xeb,  0xfb, M6809|HD6309|HC12|RF6809X12},
  "addd",  {AL2            }, {  0xc3,  0xd3,  0xe3,  0xf3, M6809|HD6309|HC12|RF6809X12},
  "adde",  {AL1            }, {0x118b,0x119b,0x11ab,0x11bb, HD6309},
  "addf",  {AL1            }, {0x11cb,0x11db,0x11eb,0x11fb, HD6309},
  "addr",  {TFR,TFR        }, {0x1030,    NA,    NA,    NA, HD6309},
  "addw",  {AL2            }, {0x108b,0x109b,0x10ab,0x10bb, HD6309},
  "aim",   {IM1,MEM        }, {    NA,  0x02,  0x62,  0x72, HD6309},
  "anda",  {AL1            }, {  0x84,  0x94,  0xa4,  0xb4, M6809|HD6309|HC12|RF6809X12},
  "andb",  {AL1            }, {  0xc4,  0xd4,  0xe4,  0xf4, M6809|HD6309|HC12|RF6809X12},
  "andcc", {IM1            }, {  0x1c,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "andcc", {IM1            }, {  0x10,    NA,    NA,    NA, HC12},
  "andd",  {AL2            }, {0x1084,0x1094,0x10a4,0x10b4, HD6309},
  "andr",  {TFR,TFR        }, {0x1034,    NA,    NA,    NA, HD6309},
  "asl",   {MEM            }, {    NA,  0x08,  0x68,  0x78, M6809|HD6309|RF6809X12},
  "asl",   {IXE            }, {    NA,    NA,  0x68,  0x78, HC12},
  "asla",  {INH            }, {  0x48,    NA,    NA,    NA, M6809|HD6309|HC12|RF6809X12},
  "aslb",  {INH            }, {  0x58,    NA,    NA,    NA, M6809|HD6309|HC12|RF6809X12},
  "asld",  {INH            }, {0x1048,    NA,    NA,    NA, HD6309},
  "asld",  {INH            }, {  0x59,    NA,    NA,    NA, HC12},
  "asr",   {MEM            }, {    NA,  0x07,  0x67,  0x77, M6809|HD6309|RF6809X12},
  "asr",   {IXE            }, {    NA,    NA,  0x67,  0x77, HC12},
  "asra",  {INH            }, {  0x47,    NA,    NA,    NA, M6809|HD6309|HC12|RF6809X12},
  "asrb",  {INH            }, {  0x57,    NA,    NA,    NA, M6809|HD6309|HC12|RF6809X12},
  "asrd",  {INH            }, {0x1047,    NA,    NA,    NA, HD6309},
  "band",  {BMR,BIT,BIT,DIR}, {    NA,0x1130,    NA,    NA, HD6309},
  "biand", {BMR,BIT,BIT,DIR}, {    NA,0x1131,    NA,    NA, HD6309},
  "beor",  {BMR,BIT,BIT,DIR}, {    NA,0x1134,    NA,    NA, HD6309},
  "bieor", {BMR,BIT,BIT,DIR}, {    NA,0x1135,    NA,    NA, HD6309},
  "bor",   {BMR,BIT,BIT,DIR}, {    NA,0x1132,    NA,    NA, HD6309},
  "bior",  {BMR,BIT,BIT,DIR}, {    NA,0x1133,    NA,    NA, HD6309},
  "bclr",  {MNI,DT1        }, {    NA,  0x4d,  0x0d,  0x1d, HC12},
  "bset",  {MNI,DT1        }, {    NA,  0x4c,  0x0c,  0x1c, HC12},
  "bgnd",  {INH            }, {  0x00,    NA,    NA,    NA, HC12},
  "bita",  {AL1            }, {  0x85,  0x95,  0xa5,  0xb5, M6809|HD6309|HC12|RF6809X12},
  "bitb",  {AL1            }, {  0xc5,  0xd5,  0xe5,  0xf5, M6809|HD6309|HC12|RF6809X12},
  "bitd",  {AL2            }, {0x1085,0x1095,0x10a5,0x10b5, HD6309},
  "bitmd", {IM1            }, {0x113c,    NA,    NA,    NA, HD6309},
  "brclr", {MNI,DT1,RLS    }, {    NA,  0x4f,  0x0f,  0x1f, HC12},
  "brset", {MNI,DT1,RLS    }, {    NA,  0x4e,  0x0e,  0x1e, HC12},
  "call",  {IXE,DT1        }, {    NA,    NA,  0x4b,  0x4a, HC12},
  "cba",   {INH            }, {0x1817,    NA,    NA,    NA, HC12},
  "clc",   {INH            }, {0x10fe,    NA,    NA,    NA, HC12},
  "cli",   {INH            }, {0x10ef,    NA,    NA,    NA, HC12},
  "clv",   {INH            }, {0x10fd,    NA,    NA,    NA, HC12},
  "clr",   {MEM            }, {    NA,  0x0f,  0x6f,  0x7f, M6809|HD6309|RF6809X12},
  "clr",   {IXE            }, {    NA,    NA,  0x69,  0x79, HC12},
  "clra",  {INH            }, {  0x4f,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "clra",  {INH            }, {  0x87,    NA,    NA,    NA, HC12},
  "clrb",  {INH            }, {  0x5f,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "clrb",  {INH            }, {  0xc7,    NA,    NA,    NA, HC12},
  "clrd",  {INH            }, {0x104f,    NA,    NA,    NA, HD6309},
  "clre",  {INH            }, {0x114f,    NA,    NA,    NA, HD6309},
  "clrf",  {INH            }, {0x115f,    NA,    NA,    NA, HD6309},
  "clrw",  {INH            }, {0x105f,    NA,    NA,    NA, HD6309},
  "cmpa",  {AL1            }, {  0x81,  0x91,  0xa1,  0xb1, M6809|HD6309|HC12|RF6809X12},
  "cmpb",  {AL1            }, {  0xc1,  0xd1,  0xe1,  0xf1, M6809|HD6309|HC12|RF6809X12},
  "cmpd",  {AL2            }, {0x1083,0x1093,0x10a3,0x10b3, M6809|HD6309},
  "cmpd",  {AL2            }, {0x0183,0x0193,0x01a3,0x01b3, RF6809X12},
  "cmpe",  {AL1            }, {0x1181,0x1191,0x11a1,0x11b1, HD6309},
  "cmpf",  {AL1            }, {0x11c1,0x11d1,0x11e1,0x11f1, HD6309},
  "cmps",  {AL2            }, {0x118c,0x119c,0x11ac,0x11bc, M6809|HD6309},
  "cmps",  {AL2            }, {0x028c,0x029c,0x02ac,0x02bc, RF6809X12},
  "cmpu",  {AL2            }, {0x1183,0x1193,0x11a3,0x11b3, M6809|HD6309},
  "cmpu",  {AL2            }, {0x0283,0x0293,0x02a3,0x02b3, RF6809X12},
  "cmpw",  {AL2            }, {0x1081,0x1091,0x10a1,0x10b1, HD6309},
  "cmpx",  {AL2            }, {  0x8c,  0x9c,  0xac,  0xbc, M6809|HD6309|RF6809X12},
  "cmpy",  {AL2            }, {0x108c,0x109c,0x10ac,0x10bc, M6809|HD6309},
  "cmpy",  {AL2            }, {0x018c,0x019c,0x01ac,0x01bc, RF6809X12},
  "cmpr",  {TFR,TFR        }, {0x1037,    NA,    NA,    NA, HD6309},
  "com",   {MEM            }, {    NA,  0x03,  0x63,  0x73, M6809|HD6309|RF6809X12},
  "com",   {IXE            }, {    NA,    NA,  0x61,  0x71, HC12},
  "coma",  {INH            }, {  0x43,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "coma",  {INH            }, {  0x41,    NA,    NA,    NA, HC12},
  "comb",  {INH            }, {  0x53,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "comb",  {INH            }, {  0x51,    NA,    NA,    NA, HC12},
  "comd",  {INH            }, {0x1043,    NA,    NA,    NA, HD6309},
  "come",  {INH            }, {0x1143,    NA,    NA,    NA, HD6309},
  "comf",  {INH            }, {0x1153,    NA,    NA,    NA, HD6309},
  "comw",  {INH            }, {0x1053,    NA,    NA,    NA, HD6309},
  "cpd",   {AL2            }, {  0x8c,  0x9c,  0xac,  0xbc, HC12},
  "cps",   {AL2            }, {  0x8f,  0x9f,  0xaf,  0xbf, HC12},
  "cpx",   {AL2            }, {  0x8e,  0x9e,  0xae,  0xbe, HC12},
  "cpy",   {AL2            }, {  0x8d,  0x9d,  0xad,  0xbd, HC12},
  "cwai",  {IM1            }, {  0x3c,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "daa",   {INH            }, {  0x19,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "daa",   {INH            }, {0x1807,    NA,    NA,    NA, HC12},
  "dbeq",  {DBR,RLD        }, {0x0400,    NA,    NA,    NA, HC12},
  "dbne",  {DBR,RLD        }, {0x0420,    NA,    NA,    NA, HC12},
  "dec",   {MEM            }, {    NA,  0x0a,  0x6a,  0x7a, M6809|HD6309|RF6809X12},
  "dec",   {IXE            }, {    NA,    NA,  0x63,  0x73, HC12},
  "deca",  {INH            }, {  0x4a,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "deca",  {INH            }, {  0x43,    NA,    NA,    NA, HC12},
  "decb",  {INH            }, {  0x5a,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "decb",  {INH            }, {  0x53,    NA,    NA,    NA, HC12},
  "decd",  {INH            }, {0x104a,    NA,    NA,    NA, HD6309},
  "dece",  {INH            }, {0x114a,    NA,    NA,    NA, HD6309},
  "decf",  {INH            }, {0x115a,    NA,    NA,    NA, HD6309},
  "decw",  {INH            }, {0x105a,    NA,    NA,    NA, HD6309},
  "des",   {INH            }, {0x1b9f,    NA,    NA,    NA, HC12},
  "dex",   {INH            }, {  0x09,    NA,    NA,    NA, HC12},
  "dey",   {INH            }, {  0x03,    NA,    NA,    NA, HC12},
  "divd",  {AL1            }, {0x118d,0x119d,0x11ad,0x11bd, HD6309},
  "divq",  {AL2            }, {0x118e,0x119e,0x11ae,0x11be, HD6309},
  "ediv",  {INH            }, {  0x11,    NA,    NA,    NA, HC12},
  "edivs", {INH            }, {0x1814,    NA,    NA,    NA, HC12},
  "eim",   {IM1,MEM        }, {    NA,  0x05,  0x65,  0x75, HD6309},
  "emacs", {EXT            }, {0x1812,    NA,    NA,    NA, HC12},
  "emaxd", {IDX            }, {    NA,    NA,0x181a,    NA, HC12},
  "emaxm", {IDX            }, {    NA,    NA,0x181e,    NA, HC12},
  "emind", {IDX            }, {    NA,    NA,0x181b,    NA, HC12},
  "eminm", {IDX            }, {    NA,    NA,0x181f,    NA, HC12},
  "emul",  {INH            }, {  0x13,    NA,    NA,    NA, HC12},
  "emuls", {INH            }, {0x1813,    NA,    NA,    NA, HC12},
  "eora",  {AL1            }, {  0x88,  0x98,  0xa8,  0xb8, M6809|HD6309|HC12|RF6809X12},
  "eorb",  {AL1            }, {  0xc8,  0xd8,  0xe8,  0xf8, M6809|HD6309|HC12|RF6809X12},
  "eord",  {AL2            }, {0x1088,0x1098,0x10a8,0x10b8, HD6309},
  "eorr",  {TFR,TFR        }, {0x1036,    NA,    NA,    NA, HD6309},
  "etbl",  {IX0            }, {0x183f,    NA,    NA,    NA, HC12},
  "exg",   {TFR,TFR        }, {  0x1e,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "exg",   {TFR,TFR        }, {  0xb7,    NA,    NA,    NA, HC12},
  "fdiv",  {INH            }, {0x1811,    NA,    NA,    NA, HC12},
  "ibeq",  {DBR,RLD        }, {0x0480,    NA,    NA,    NA, HC12},
  "ibne",  {DBR,RLD        }, {0x04a0,    NA,    NA,    NA, HC12},
  "idiv",  {INH            }, {0x1810,    NA,    NA,    NA, HC12},
  "idivs", {INH            }, {0x1815,    NA,    NA,    NA, HC12},
  "inc",   {MEM            }, {    NA,  0x0c,  0x6c,  0x7c, M6809|HD6309|RF6809X12},
  "inc",   {IXE            }, {    NA,    NA,  0x62,  0x72, HC12},
  "inca",  {INH            }, {  0x4c,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "inca",  {INH            }, {  0x42,    NA,    NA,    NA, HC12},
  "incb",  {INH            }, {  0x5c,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "incb",  {INH            }, {  0x52,    NA,    NA,    NA, HC12},
  "incd",  {INH            }, {0x104c,    NA,    NA,    NA, HD6309},
  "ince",  {INH            }, {0x114c,    NA,    NA,    NA, HD6309},
  "incf",  {INH            }, {0x115c,    NA,    NA,    NA, HD6309},
  "incw",  {INH            }, {0x105c,    NA,    NA,    NA, HD6309},
  "ins",   {INH            }, {0x1b81,    NA,    NA,    NA, HC12},
  "inx",   {INH            }, {  0x08,    NA,    NA,    NA, HC12},
  "iny",   {INH            }, {  0x02,    NA,    NA,    NA, HC12},
  "jmp",   {MEM            }, {    NA,  0x0e,  0x6e,  0x7e, M6809|HD6309|RF6809X12},
  "jmp",   {IXE            }, {    NA,    NA,  0x05,  0x06, HC12},
  "jsr",   {MEM            }, {    NA,  0x9d,  0xad,  0xbd, M6809|HD6309|RF6809X12},
  "jsr",   {MEM            }, {    NA,  0x17,  0x15,  0x16, HC12},
  "lda",   {AL1            }, {  0x86,  0x96,  0xa6,  0xb6, M6809|HD6309|RF6809X12},
  "ldaa",  {AL1            }, {  0x86,  0x96,  0xa6,  0xb6, HC12},
  "ldb",   {AL1            }, {  0xc6,  0xd6,  0xe6,  0xf6, M6809|HD6309|RF6809X12},
  "ldab",  {AL1            }, {  0xc6,  0xd6,  0xe6,  0xf6, HC12},
  "ldd",   {AL2            }, {  0xcc,  0xdc,  0xec,  0xfc, M6809|HD6309|HC12|RF6809X12},
  "lde",   {AL1            }, {0x1186,0x1196,0x11a6,0x11b6, HD6309},
  "ldf",   {AL1            }, {0x11c6,0x11d6,0x11e6,0x11f6, HD6309},
  "ldmd",  {IM1            }, {0x013d,    NA,    NA,    NA, HD6309},
  "ldq",   {AL4            }, {  0xcd,0x10dc,0x10ec,0x10fc, HD6309},
  "lds",   {AL2            }, {0x10ce,0x10de,0x10ee,0x10fe, M6809|HD6309},
  "lds",   {AL2            }, {0x01ce,0x01de,0x01ee,0x01fe, RF6809X12},
  "lds",   {AL2            }, {  0xcf,  0xdf,  0xef,  0xff, HC12},
  "ldu",   {AL2            }, {  0xce,  0xde,  0xee,  0xfe, M6809|HD6309|RF6809X12},
  "ldw",   {AL2            }, {0x1086,0x1096,0x10a6,0x10b6, HD6309},
  "ldx",   {AL2            }, {  0x8e,  0x9e,  0xae,  0xbe, M6809|HD6309|RF6809X12},
  "ldx",   {AL2            }, {  0xce,  0xde,  0xee,  0xfe, HC12},
  "ldy",   {AL2            }, {0x108e,0x109e,0x10ae,0x10be, M6809|HD6309},
  "ldy",   {AL2            }, {0x018e,0x019e,0x01ae,0x01be, RF6809X12},
  "ldy",   {AL2            }, {  0xcd,  0xdd,  0xed,  0xfd, HC12},
  "ldbt",  {BMR,BIT,BIT,DIR}, {    NA,0x1136,    NA,    NA, HD6309},
  "leas",  {IDX            }, {    NA,    NA,  0x32,    NA, M6809|HD6309|RF6809X12},
  "leas",  {DIX            }, {    NA,    NA,  0x1b,    NA, HC12},
  "leau",  {IDX            }, {    NA,    NA,  0x33,    NA, M6809|HD6309|RF6809X12},
  "leax",  {IDX            }, {    NA,    NA,  0x30,    NA, M6809|HD6309|RF6809X12},
  "leax",  {DIX            }, {    NA,    NA,  0x1a,    NA, HC12},
  "leay",  {IDX            }, {    NA,    NA,  0x31,    NA, M6809|HD6309|RF6809X12},
  "leay",  {DIX            }, {    NA,    NA,  0x19,    NA, HC12},
  "lsl",   {MEM            }, {    NA,  0x08,  0x68,  0x78, M6809|HD6309|RF6809X12},
  "lsl",   {IXE            }, {    NA,    NA,  0x68,  0x78, HC12},
  "lsla",  {INH            }, {  0x48,    NA,    NA,    NA, M6809|HD6309|HC12|RF6809X12},
  "lslb",  {INH            }, {  0x58,    NA,    NA,    NA, M6809|HD6309|HC12|RF6809X12},
  "lsld",  {INH            }, {0x1048,    NA,    NA,    NA, HD6309},
  "lsld",  {INH            }, {  0x59,    NA,    NA,    NA, HC12},
  "lsr",   {MEM            }, {    NA,  0x04,  0x64,  0x74, M6809|HD6309|RF6809X12},
  "lsr",   {IXE            }, {    NA,    NA,  0x64,  0x74, HC12},
  "lsra",  {INH            }, {  0x44,    NA,    NA,    NA, M6809|HD6309|HC12|RF6809X12},
  "lsrb",  {INH            }, {  0x54,    NA,    NA,    NA, M6809|HD6309|HC12|RF6809X12},
  "lsrd",  {INH            }, {0x1044,    NA,    NA,    NA, HD6309},
  "lsrd",  {INH            }, {  0x49,    NA,    NA,    NA, HC12},
  "lsrw",  {INH            }, {0x1054,    NA,    NA,    NA, HD6309},
  "maxa",  {IDX            }, {    NA,    NA,0x1818,    NA, HC12},
  "maxm",  {IDX            }, {    NA,    NA,0x181c,    NA, HC12},
  "mem",   {INH            }, {  0x01,    NA,    NA,    NA, HC12},
  "mina",  {IDX            }, {    NA,    NA,0x1819,    NA, HC12},
  "minm",  {IDX            }, {    NA,    NA,0x181d,    NA, HC12},
  "movb",  {IM1,EXT        }, {0x180b,    NA,    NA,    NA, HC12|MOVE},
  "movb",  {IM1,DI0        }, {0x1808,    NA,    NA,    NA, HC12|MOVE},
  "movb",  {EXT,EXT        }, {0x180c,    NA,    NA,    NA, HC12|MOVE},
  "movb",  {EXT,DI0        }, {0x1809,    NA,    NA,    NA, HC12|MOVE},
  "movb",  {DI0,EXT        }, {0x180d,    NA,    NA,    NA, HC12|MOVE},
  "movb",  {DI0,DI0        }, {0x180a,    NA,    NA,    NA, HC12|MOVE},
  "movw",  {IM2,EXT        }, {0x1803,    NA,    NA,    NA, HC12|MOVE},
  "movw",  {IM2,DI0        }, {0x1800,    NA,    NA,    NA, HC12|MOVE},
  "movw",  {EXT,EXT        }, {0x1804,    NA,    NA,    NA, HC12|MOVE},
  "movw",  {EXT,DI0        }, {0x1801,    NA,    NA,    NA, HC12|MOVE},
  "movw",  {DI0,EXT        }, {0x1805,    NA,    NA,    NA, HC12|MOVE},
  "movw",  {DI0,DI0        }, {0x1802,    NA,    NA,    NA, HC12|MOVE},
  "mul",   {INH            }, {  0x3d,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "mul",   {INH            }, {  0x12,    NA,    NA,    NA, HC12},
  "muld",  {AL2            }, {0x118f,0x119f,0x11af,0x11bf, HD6309},
  "neg",   {MEM            }, {    NA,  0x00,  0x60,  0x70, M6809|HD6309|RF6809X12},
  "neg",   {IXE            }, {    NA,    NA,  0x60,  0x70, HC12},
  "nega",  {INH            }, {  0x40,    NA,    NA,    NA, M6809|HD6309|HC12|RF6809X12},
  "negb",  {INH            }, {  0x50,    NA,    NA,    NA, M6809|HD6309|HC12|RF6809X12},
  "negd",  {INH            }, {0x1040,    NA,    NA,    NA, HD6309},
  "nop",   {INH            }, {  0x12,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "nop",   {INH            }, {  0xa7,    NA,    NA,    NA, HC12},
  "oim",   {IM1,MEM        }, {    NA,  0x01,  0x61,  0x71, HD6309},
  "ora",   {AL1            }, {  0x8a,  0x9a,  0xaa,  0xba, M6809|HD6309|RF6809X12},
  "orb",   {AL1            }, {  0xca,  0xda,  0xea,  0xfa, M6809|HD6309|RF6809X12},
  "oraa",  {AL1            }, {  0x8a,  0x9a,  0xaa,  0xba, HC12},
  "orab",  {AL1            }, {  0xca,  0xda,  0xea,  0xfa, HC12},
  "ord",   {AL2            }, {0x108a,0x109a,0x10aa,0x10ba, HD6309},
  "orr",   {TFR,TFR        }, {0x1035,    NA,    NA,    NA, HD6309},
  "orcc",  {IM1            }, {  0x1a,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "orcc",  {IM1            }, {  0x14,    NA,    NA,    NA, HC12},
  "pshs",  {PPL            }, {  0x34,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "pshs",  {IM1            }, {  0x34,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "pshsw", {INH            }, {0x1038,    NA,    NA,    NA, HD6309},
  "pshu",  {PPL            }, {  0x36,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "pshu",  {IM1            }, {  0x36,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "pshuw", {INH            }, {0x103a,    NA,    NA,    NA, HD6309},
  "psha",  {INH            }, {  0x36,    NA,    NA,    NA, HC12},
  "pshb",  {INH            }, {  0x37,    NA,    NA,    NA, HC12},
  "pshc",  {INH            }, {  0x39,    NA,    NA,    NA, HC12},
  "pshd",  {INH            }, {  0x3b,    NA,    NA,    NA, HC12},
  "pshx",  {INH            }, {  0x34,    NA,    NA,    NA, HC12},
  "pshy",  {INH            }, {  0x35,    NA,    NA,    NA, HC12},
  "puls",  {PPL            }, {  0x35,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "puls",  {IM1            }, {  0x35,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "pulsw", {INH            }, {0x1039,    NA,    NA,    NA, HD6309},
  "pulu",  {PPL            }, {  0x37,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "pulu",  {IM1            }, {  0x37,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "puluw", {INH            }, {0x103b,    NA,    NA,    NA, HD6309},
  "pula",  {INH            }, {  0x32,    NA,    NA,    NA, HC12},
  "pulb",  {INH            }, {  0x33,    NA,    NA,    NA, HC12},
  "pulc",  {INH            }, {  0x38,    NA,    NA,    NA, HC12},
  "puld",  {INH            }, {  0x3a,    NA,    NA,    NA, HC12},
  "pulx",  {INH            }, {  0x30,    NA,    NA,    NA, HC12},
  "puly",  {INH            }, {  0x31,    NA,    NA,    NA, HC12},
  "rev",   {INH            }, {0x183a,    NA,    NA,    NA, HC12},
  "revw",  {INH            }, {0x183b,    NA,    NA,    NA, HC12},
  "rol",   {MEM            }, {    NA,  0x09,  0x69,  0x79, M6809|HD6309|RF6809X12},
  "rol",   {IXE            }, {    NA,    NA,  0x65,  0x75, HC12},
  "rola",  {INH            }, {  0x49,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "rola",  {INH            }, {  0x45,    NA,    NA,    NA, HC12},
  "rolb",  {INH            }, {  0x59,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "rolb",  {INH            }, {  0x55,    NA,    NA,    NA, HC12},
  "rold",  {INH            }, {0x1049,    NA,    NA,    NA, HD6309},
  "rolw",  {INH            }, {0x1059,    NA,    NA,    NA, HD6309},
  "ror",   {MEM            }, {    NA,  0x06,  0x66,  0x76, M6809|HD6309|RF6809X12},
  "ror",   {IXE            }, {    NA,    NA,  0x66,  0x76, HC12},
  "rora",  {INH            }, {  0x46,    NA,    NA,    NA, M6809|HD6309|HC12|RF6809X12},
  "rorb",  {INH            }, {  0x56,    NA,    NA,    NA, M6809|HD6309|HC12|RF6809X12},
  "rord",  {INH            }, {0x1046,    NA,    NA,    NA, HD6309},
  "rorw",  {INH            }, {0x1056,    NA,    NA,    NA, HD6309},
  "rtc",   {INH            }, {  0x0a,    NA,    NA,    NA, HC12},
  "rtf",   {INH            }, {  0x38,    NA,    NA,    NA, RF6809X12},
  "rti",   {INH            }, {  0x3b,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "rti",   {INH            }, {  0x0b,    NA,    NA,    NA, HC12},
  "rts",   {INH            }, {  0x39,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "rts",   {INH            }, {  0x3d,    NA,    NA,    NA, HC12},
  "sba",   {INH            }, {0x1816,    NA,    NA,    NA, HC12},
  "sbca",  {AL1            }, {  0x82,  0x92,  0xa2,  0xb2, M6809|HD6309|HC12|RF6809X12},
  "sbcb",  {AL1            }, {  0xc2,  0xd2,  0xe2,  0xf2, M6809|HD6309|HC12|RF6809X12},
  "sbcd",  {AL2            }, {0x1082,0x1092,0x10a2,0x10b2, HD6309},
  "sbcr",  {TFR,TFR        }, {0x1033,    NA,    NA,    NA, HD6309},
  "sec",   {INH            }, {0x1401,    NA,    NA,    NA, HC12},
  "sei",   {INH            }, {0x1410,    NA,    NA,    NA, HC12},
  "sev",   {INH            }, {0x1402,    NA,    NA,    NA, HC12},
  "sex",   {TFR,TFR        }, {  0xb7,    NA,    NA,    NA, HC12},
  "sex",   {INH            }, {  0x1d,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "sexw",  {INH            }, {  0x14,    NA,    NA,    NA, HD6309},
  "sta",   {MEM            }, {    NA,  0x97,  0xa7,  0xb7, M6809|HD6309|RF6809X12},
  "staa",  {MEM            }, {    NA,  0x5a,  0x6a,  0x7a, HC12},
  "stb",   {MEM            }, {    NA,  0xd7,  0xe7,  0xf7, M6809|HD6309|RF6809X12},
  "stab",  {MEM            }, {    NA,  0x5b,  0x6b,  0x7b, HC12},
  "std",   {MEM            }, {    NA,  0xdd,  0xed,  0xfd, M6809|HD6309|RF6809X12},
  "std",   {MEM            }, {    NA,  0x5c,  0x6c,  0x7c, HC12},
  "ste",   {MEM            }, {    NA,0x1197,0x11a7,0x11b7, HD6309},
  "stf",   {MEM            }, {    NA,0x11d7,0x11e7,0x11f7, HD6309},
  "stq",   {MEM            }, {    NA,0x10dd,0x10ed,0x10fd, HD6309},
  "sts",   {MEM            }, {    NA,0x10df,0x10ef,0x10ff, M6809|HD6309},
  "sts",   {MEM            }, {    NA,0x01df,0x01ef,0x01ff, RF6809X12},
  "sts",   {MEM            }, {    NA,  0x5f,  0x6f,  0x7f, HC12},
  "stu",   {MEM            }, {    NA,  0xdf,  0xef,  0xff, M6809|HD6309|RF6809X12},
  "stw",   {MEM            }, {    NA,0x1097,0x10a7,0x10b7, HD6309},
  "stx",   {MEM            }, {    NA,  0x9f,  0xaf,  0xbf, M6809|HD6309|RF6809X12},
  "stx",   {MEM            }, {    NA,  0x5e,  0x6e,  0x7e, HC12},
  "sty",   {MEM            }, {    NA,0x109f,0x10af,0x10bf, M6809|HD6309},
  "sty",   {MEM            }, {    NA,0x019f,0x01af,0x01bf, RF6809X12},
  "sty",   {MEM            }, {    NA,  0x5d,  0x6d,  0x7d, HC12},
  "stbt",  {BMR,BIT,BIT,DIR}, {    NA,0x1137,    NA,    NA, HD6309},
  "stop",  {INH            }, {0x183e,    NA,    NA,    NA, HC12},
  "suba",  {AL1            }, {  0x80,  0x90,  0xa0,  0xb0, M6809|HD6309|HC12|RF6809X12},
  "subb",  {AL1            }, {  0xc0,  0xd0,  0xe0,  0xf0, M6809|HD6309|HC12|RF6809X12},
  "subd",  {AL2            }, {  0x83,  0x93,  0xa3,  0xb3, M6809|HD6309|HC12|RF6809X12},
  "sube",  {AL1            }, {0x1180,0x1190,0x11a0,0x11b0, HD6309},
  "subf",  {AL1            }, {0x11c0,0x11d0,0x11e0,0x11f0, HD6309},
  "subr",  {TFR,TFR        }, {0x1032,    NA,    NA,    NA, HD6309},
  "subw",  {AL2            }, {0x1080,0x1090,0x10a0,0x10b0, HD6309},
  "swi",   {INH            }, {  0x3f,    NA,    NA,    NA, M6809|HD6309|HC12|RF6809X12},
  "swi2",  {INH            }, {0x103f,    NA,    NA,    NA, M6809|HD6309},
  "swi2",  {INH            }, {0x013f,    NA,    NA,    NA, RF6809X12},
  "swi3",  {INH            }, {0x113f,    NA,    NA,    NA, M6809|HD6309},
  "swi3",  {INH            }, {0x023f,    NA,    NA,    NA, RF6809X12},
  "sync",  {INH            }, {  0x13,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "tab",   {INH            }, {0x180e,    NA,    NA,    NA, HC12},
  "tap",   {INH            }, {0xb702,    NA,    NA,    NA, HC12},
  "tba",   {INH            }, {0x180f,    NA,    NA,    NA, HC12},
  "tbeq",  {DBR,RLD        }, {0x0440,    NA,    NA,    NA, HC12},
  "tbne",  {DBR,RLD        }, {0x0460,    NA,    NA,    NA, HC12},
  "tbl",   {DI0            }, {    NA,    NA,    0x183d,NA, HC12},
  "tfm",   {TMP,TMP        }, {0x1138,    NA,    NA,    NA, HD6309},
  "tfm",   {TMM,TMM        }, {0x1139,    NA,    NA,    NA, HD6309},
  "tfm",   {TMP,TFM        }, {0x113a,    NA,    NA,    NA, HD6309},
  "tfm",   {TFM,TMP        }, {0x113b,    NA,    NA,    NA, HD6309},
  "tfr",   {TFR,TFR        }, {  0x1f,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "tfr",   {TFR,TFR        }, {  0xb7,    NA,    NA,    NA, HC12},
  "tim",   {IM1,MEM        }, {    NA,  0x0b,  0x6b,  0x7b, HD6309},
  "tpa",   {INH            }, {0xb720,    NA,    NA,    NA, HC12},
  "trap",  {DT1,           }, {  0x18,    NA,    NA,    NA, HC12},
  "tst",   {MEM            }, {    NA,  0x0d,  0x6d,  0x7d, M6809|HD6309|RF6809X12},
  "tst",   {IXE            }, {    NA,    NA,  0xe7,  0xf7, HC12},
  "tsta",  {INH            }, {  0x4d,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "tsta",  {INH            }, {  0x97,    NA,    NA,    NA, HC12},
  "tstb",  {INH            }, {  0x5d,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "tstb",  {INH            }, {  0xd7,    NA,    NA,    NA, HC12},
  "tstd",  {INH            }, {0x104d,    NA,    NA,    NA, HD6309},
  "tste",  {INH            }, {0x114d,    NA,    NA,    NA, HD6309},
  "tstf",  {INH            }, {0x115d,    NA,    NA,    NA, HD6309},
  "tstw",  {INH            }, {0x105d,    NA,    NA,    NA, HD6309},
  "tsx",   {INH            }, {0xb775,    NA,    NA,    NA, HC12},
  "tsy",   {INH            }, {0xb776,    NA,    NA,    NA, HC12},
  "txs",   {INH            }, {0xb757,    NA,    NA,    NA, HC12},
  "tys",   {INH            }, {0xb767,    NA,    NA,    NA, HC12},
  "wai",   {INH            }, {  0x3e,    NA,    NA,    NA, HC12},
  "wav",   {INH            }, {0x183c,    NA,    NA,    NA, HC12},
  "wavr",  {INH            }, {  0x3c,    NA,    NA,    NA, HC12},
  "xgdx",  {INH            }, {0xb7c5,    NA,    NA,    NA, HC12},
  "xgdy",  {INH            }, {0xb7c6,    NA,    NA,    NA, HC12},
  "bsr",   {RLS            }, {  0x8d,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bsr",   {RLS            }, {  0x07,    NA,    NA,    NA, HC12},
  "lbsr",  {RLL            }, {  0x17,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bra",   {RLS            }, {  0x20,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bra",   {RLS            }, {  0x20,    NA,    NA,    NA, HC12},
  "lbra",  {RLL            }, {  0x16,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "lbra",  {RLL            }, {0x1820,    NA,    NA,    NA, HC12},
  "brn",   {RLS            }, {  0x21,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "brn",   {RLS            }, {  0x21,    NA,    NA,    NA, HC12},
  "lbrn",  {RLL            }, {0x1021,    NA,    NA,    NA, M6809|HD6309},
  "lbrn",  {RLL            }, {0x0121,    NA,    NA,    NA, RF6809X12},
  "lbrn",  {RLL            }, {0x1821,    NA,    NA,    NA, HC12},
  "bhi",   {RLS            }, {  0x22,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bhi",   {RLS            }, {  0x22,    NA,    NA,    NA, HC12},
  "lbhi",  {RLL            }, {0x1022,    NA,    NA,    NA, M6809|HD6309},
  "lbhi",  {RLL            }, {0x0122,    NA,    NA,    NA, RF6809X12},
  "lbhi",  {RLL            }, {0x1822,    NA,    NA,    NA, HC12},
  "bls",   {RLS            }, {  0x23,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bls",   {RLS            }, {  0x23,    NA,    NA,    NA, HC12},
  "lbls",  {RLL            }, {0x1023,    NA,    NA,    NA, M6809|HD6309},
  "lbls",  {RLL            }, {0x0123,    NA,    NA,    NA, RF6809X12},
  "lbls",  {RLL            }, {0x1823,    NA,    NA,    NA, HC12},
  "bcc",   {RLS            }, {  0x24,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bcc",   {RLS            }, {  0x24,    NA,    NA,    NA, HC12},
  "lbcc",  {RLL            }, {0x1024,    NA,    NA,    NA, M6809|HD6309},
  "lbcc",  {RLL            }, {0x0124,    NA,    NA,    NA, RF6809X12},
  "lbcc",  {RLL            }, {0x1824,    NA,    NA,    NA, HC12},
  "bcs",   {RLS            }, {  0x25,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bcs",   {RLS            }, {  0x25,    NA,    NA,    NA, HC12},
  "lbcs",  {RLL            }, {0x1025,    NA,    NA,    NA, M6809|HD6309},
  "lbcs",  {RLL            }, {0x0125,    NA,    NA,    NA, RF6809X12},
  "lbcs",  {RLL            }, {0x1825,    NA,    NA,    NA, HC12},
  "bne",   {RLS            }, {  0x26,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bne",   {RLS            }, {  0x26,    NA,    NA,    NA, HC12},
  "lbne",  {RLL            }, {0x1026,    NA,    NA,    NA, M6809|HD6309},
  "lbne",  {RLL            }, {0x0126,    NA,    NA,    NA, RF6809X12},
  "lbne",  {RLL            }, {0x1826,    NA,    NA,    NA, HC12},
  "beq",   {RLS            }, {  0x27,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "beq",   {RLS            }, {  0x27,    NA,    NA,    NA, HC12},
  "lbeq",  {RLL            }, {0x1027,    NA,    NA,    NA, M6809|HD6309},
  "lbeq",  {RLL            }, {0x0127,    NA,    NA,    NA, RF6809X12},
  "lbeq",  {RLL            }, {0x1827,    NA,    NA,    NA, HC12},
  "bvc",   {RLS            }, {  0x28,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bvc",   {RLS            }, {  0x28,    NA,    NA,    NA, HC12},
  "lbvc",  {RLL            }, {0x1028,    NA,    NA,    NA, M6809|HD6309},
  "lbvc",  {RLL            }, {0x0128,    NA,    NA,    NA, RF6809X12},
  "lbvc",  {RLL            }, {0x1828,    NA,    NA,    NA, HC12},
  "bvs",   {RLS            }, {  0x29,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bvs",   {RLS            }, {  0x29,    NA,    NA,    NA, HC12},
  "lbvs",  {RLL            }, {0x1029,    NA,    NA,    NA, M6809|HD6309},
  "lbvs",  {RLL            }, {0x0129,    NA,    NA,    NA, RF6809X12},
  "lbvs",  {RLL            }, {0x1829,    NA,    NA,    NA, HC12},
  "bpl",   {RLS            }, {  0x2a,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bpl",   {RLS            }, {  0x2a,    NA,    NA,    NA, HC12},
  "lbpl",  {RLL            }, {0x102a,    NA,    NA,    NA, M6809|HD6309},
  "lbpl",  {RLL            }, {0x012a,    NA,    NA,    NA, RF6809X12},
  "lbpl",  {RLL            }, {0x182a,    NA,    NA,    NA, HC12},
  "bmi",   {RLS            }, {  0x2b,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bmi",   {RLS            }, {  0x2b,    NA,    NA,    NA, HC12},
  "lbmi",  {RLL            }, {0x102b,    NA,    NA,    NA, M6809|HD6309},
  "lbmi",  {RLL            }, {0x012b,    NA,    NA,    NA, RF6809X12},
  "lbmi",  {RLL            }, {0x182b,    NA,    NA,    NA, HC12},
  "bge",   {RLS            }, {  0x2c,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bge",   {RLS            }, {  0x2c,    NA,    NA,    NA, HC12},
  "lbge",  {RLL            }, {0x102c,    NA,    NA,    NA, M6809|HD6309},
  "lbge",  {RLL            }, {0x012c,    NA,    NA,    NA, RF6809X12},
  "lbge",  {RLL            }, {0x182c,    NA,    NA,    NA, HC12},
  "blt",   {RLS            }, {  0x2d,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "blt",   {RLS            }, {  0x2d,    NA,    NA,    NA, HC12},
  "lblt",  {RLL            }, {0x102d,    NA,    NA,    NA, M6809|HD6309},
  "lblt",  {RLL            }, {0x012d,    NA,    NA,    NA, RF6809X12},
  "lblt",  {RLL            }, {0x182d,    NA,    NA,    NA, HC12},
  "bgt",   {RLS            }, {  0x2e,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bgt",   {RLS            }, {  0x2e,    NA,    NA,    NA, HC12},
  "lbgt",  {RLL            }, {0x102e,    NA,    NA,    NA, M6809|HD6309},
  "lbgt",  {RLL            }, {0x012e,    NA,    NA,    NA, RF6809X12},
  "lbgt",  {RLL            }, {0x182e,    NA,    NA,    NA, HC12},
  "ble",   {RLS            }, {  0x2f,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "ble",   {RLS            }, {  0x2f,    NA,    NA,    NA, HC12},
  "lble",  {RLL            }, {0x102f,    NA,    NA,    NA, M6809|HD6309},
  "lble",  {RLL            }, {0x012f,    NA,    NA,    NA, RF6809X12},
  "lble",  {RLL            }, {0x182f,    NA,    NA,    NA, HC12},
  "bhs",   {RLS            }, {  0x24,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "bhs",   {RLS            }, {  0x24,    NA,    NA,    NA, HC12},
  "lbhs",  {RLL            }, {0x1024,    NA,    NA,    NA, M6809|HD6309},
  "lbhs",  {RLL            }, {0x0124,    NA,    NA,    NA, RF6809X12},
  "lbhs",  {RLL            }, {0x1824,    NA,    NA,    NA, HC12},
  "blo",   {RLS            }, {  0x25,    NA,    NA,    NA, M6809|HD6309|RF6809X12},
  "blo",   {RLS            }, {  0x25,    NA,    NA,    NA, HC12},
  "lblo",  {RLL            }, {0x0125,    NA,    NA,    NA, RF6809X12},
  "lblo",  {RLL            }, {0x1025,    NA,    NA,    NA, M6809|HD6309},
  "lblo",  {RLL            }, {0x1825,    NA,    NA,    NA, HC12},
