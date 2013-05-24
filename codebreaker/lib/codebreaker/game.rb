module Codebreaker
	class Game
		def initialize(output)
			@output = output
		end

		def start(secret)
			@secret = secret
			@output.puts "Welcome to Codebreaker!"
			@output.puts "Enter guess:"
		end

		def guess(guess)
			@memo = {}
			_guess = guess.slice(0, 4)
			n_match = e_match = 0
			(0..._guess.length).each do |index|
				n_match += 1 if number_match?(_guess, index)
				e_match += 1 if exact_match?(_guess, index)
				@memo[_guess[index]] = true
			end
			@output.puts [n_match, e_match].join(':')
		end

		private

		def exact_match?(guess, index)
			@secret[index] == guess[index]
		end

		def number_match?(guess, index)
			return false if @memo[guess[index]]
			@secret.include?(guess[index])
		end
	end
end