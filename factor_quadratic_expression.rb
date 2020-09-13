a = ARGV[0].to_i
b = ARGV[1].to_i
c = ARGV[2].to_i

def get_positive_factors x
	x = x.abs()

	positive_factors = [1]

	for i in 2..(x/2)
		if x % i == 0
			positive_factors << i
		end
	end

	positive_factors << x
end

def get_pair a, b, c
	positive_factors = get_positive_factors(a * c)

	positive_factors_length = positive_factors.length()

	last_index_to_check = nil

	if positive_factors_length % 2 == 0
		last_index_to_check = (positive_factors_length / 2) - 1
	else
		last_index_to_check = positive_factors_length / 2
	end

	for i in 0..last_index_to_check
		x = positive_factors[i]
		y = positive_factors[positive_factors_length - i - 1]

		if x * y != a * c
			x = x * -1
		end

		if x + y == b
			return [x, y]
		else
			x = x * -1
			y = y * -1

			if x + y == b
				return [x, y]
			end
		end
	end

	STDERR.puts("There isn't a solution within the integers.")

	exit(false)
end

def simplify_fraction fraction
	numerator   = fraction[0]
	denominator = fraction[1]

	gcd = numerator.gcd(denominator)

	return [(numerator / gcd), (denominator / gcd)]
end

def get_simplified_fractions a, pair
	fraction1 = [pair[0], a]
	fraction2 = [pair[1], a]

	return simplify_fraction(fraction1), simplify_fraction(fraction2)
end

def main (a, b, c)
	pair = get_pair(a, b, c)

	fraction1, fraction2 = get_simplified_fractions(a, pair)

	x_coefficient1 = fraction1[1] == 1 ? '' : fraction1[1].to_s
	x_coefficient2 = fraction2[1] == 1 ? '' : fraction2[1].to_s

	constant1 = fraction1[0] > 0 ? "+ #{fraction1[0]}" : "- #{fraction1[0].abs()}"
	constant2 = fraction2[0] > 0 ? "+ #{fraction2[0]}" : "- #{fraction2[0].abs()}"

	puts "(#{x_coefficient1}x #{constant1})(#{x_coefficient2}x #{constant2})"
end

main(a, b, c)
