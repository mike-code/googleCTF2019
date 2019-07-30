from z3 import *

s = Solver()

TARGET = BitVecVal(2683675001140, 128)
RCX = BitVec('RCX', 128)
RBX = BitVec('RBX', 128)
RDX = BitVec('RDX', 128)
REX = BitVec('REX', 128)

s.add(
	RDX < 1600000000,
	RDX > 1500000000,
	RCX == (0x5deece66d * RDX + 0xb) & 0xFFFFFFFFFFFFFFFF,
	RBX == ((RCX * 0x10001) & 0xFFFFFFFFFFFFFFFF0000000000000000) >> 64,
	REX == ((RCX - RBX >> 0x1) + RBX >> 0x2f),
	TARGET == ((RCX - (REX << 0x30)) + (REX))
)

if s.check() == sat:
	print s.model()
