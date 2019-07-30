# Every palindrome with an even number of digits is divisible by 11, so 11 is the only member of the sequence with an even number of digits.

require 'prime'

base = [2,3,5,7,11]

data = [
	[1, [106,119,113,119,49,74,172,242,216,208,339,264,344,267,743,660,893,892,1007,975,10319,10550,10503,11342,11504,12533,12741,12833,13437,13926,13893,14450,14832,15417,15505,16094,16285,16599,16758,17488]],
	[99, [93766,93969,94440,94669,94952,94865,95934,96354,96443,96815,97280,97604,97850,98426]],
	[765, [9916239,9918082,9919154,9921394,9923213,9926376,9927388,9931494,9932289,9935427,9938304,9957564,9965794,9978842,9980815,9981858,9989997,100030045,100049982,100059926,100111100,100131019,100160922,100404094,100656111,100707036,100767085,100887990,100998966,101030055,101060206,101141058]]
]

def genpals(n)
	return [*0..9] if n == 1
	return genpals(n-2).product([*0..9]).map{ |i, d| d*10**(n-1) + i*10 + d }
end

def getprimes(max)
	max.downto(3).map{ |n|
		genpals(n).select{ |i| i >= 10**(n-1) }.select { |n| Prime.prime? n } if n.odd?
	}
end

primes = [0,0] + (getprimes(9).flatten.compact + base).sort

p data.map {|s, dat| dat.map { |c| (c^primes[s+=1]).chr }}.flatten.join
