require "openssl"

N = 17450892350509567071590987572582143158927907441748820483575144211411640241849663641180283816984167447652133133054833591585389505754635416604577584488321462013117163124742030681698693455489404696371546386866372290759608301392572928615767980244699473803730080008332364994345680261823712464595329369719516212105135055607592676087287980208987076052877442747436020751549591608244950255761481664468992126299001817410516694015560044888704699389291971764957871922598761298482950811618390145762835363357354812871474680543182075024126064364949000115542650091904557502192704672930197172086048687333172564520657739528469975770627

def isqrt(val)
	bit_len = val.to_s(2).length

	a = 2**(bit_len/2)
	b = a

	1.upto(bit_len/2).map{b /= 2}.each{ |n|
		s = a*a
		break if s == val
		s > val ? a -= n : a += n
	}

	a += 1 if a*a < val
	a
end

def digRoot(val)
	until val.length == 1 do
		val = val.each_char.map(&:to_i).sum.to_s
	end

	[1,4,7,9].include? val.to_i
end

def isPerfect(val)
	(x, y) = val.to_s.each_char.to_a.reverse[0..1].map(&:to_i)
	return false if [2,3,7,8].include? x
	return false if y != nil && x == 6 && y % 2 == 0
	return false if y != nil && x != 6 && y % 2 == 1
	return false if y != nil && x == 5 && y != 2
	return false if y != nil && [y,x].join.to_i % 2 == 0 && [y,x].join.to_i % 4 != 0
	return false if !digRoot(val.to_s)

	q = isqrt(val)
	q*q == val
end

it = 1000
parts = [0] + 1.upto(11).map { 1000 - it /= 1.5 }.map(&:to_i) + [1000]

FORN = 4*N
parts = parts.each_cons(2).map{|m| m[0] += 1; m }

p isqrt(N)

# parts.each { |from,to|
# 	fork do
# 		from.upto(to) { |a| 1.upto(a) { |b|
# 			pierw = FORN*a*b
# 			check = isqrt(pierw)**2-pierw
# 			next unless isPerfect(check)
# 			p "%d->%d: %d" % [a, b, isqrt(check)]
# 		}}
# 	end
# }

_a = 794
_b = 607
_x = 9125

P = (isqrt(_x**2+FORN*_a*_b)-_x)/(2*_a)
Q = N/P

msg = "50fb0b3f17315f7dfa25378fa0b06c8d955fad0493365669bbaa524688128ee9099ab713a3369a5844bdd99a5db98f333ef55159d3025630c869216889be03120e3a4bd6553d7111c089220086092bcffc5e42f1004f9888f25892a7ca007e8ac6de9463da46f71af4c8a8f806bee92bf79a8121a7a34c3d564ac7f11b224dc090d97fdb427c10867ad177ec35525b513e40bef3b2ba3e6c97cb31d4fe3a6231fdb15643b84a1ce704838d8b99e5b0737e1fd30a9cc51786dcac07dcb9c0161fc754cda5380fdf3147eb4fbe49bc9821a0bcad98d6df9fbdf63cf7d7a5e4f6cbea4b683dfa965d0bd51f792047e393ddd7b7d99931c3ed1d033cebc91968d43f"

fi = (P-1)*(Q-1)
e = 65537

d = e.to_bn.mod_inverse(fi)
# p d

# print [msg.to_i(16).to_bn.mod_exp(d, N).to_s(16)].pack('H*')

print msg.to_i(16).to_bn.mod_exp(d, N).to_s(0)

