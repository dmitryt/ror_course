require 'spec_helper'

module Codebreaker
	describe Game do
		let(:output) {double('output').as_null_object}
		let(:game) {Game.new(output)}

		describe "#start" do

			it "sends a welcome message" do
				output.should_receive(:puts).with("Welcome to Codebreaker!")
				game.start('1234')
			end
			it "prompts for the first guess" do
				output.should_receive(:puts).with("Enter guess:")
				game.start('1234')
			end
		end

		describe "#guess" do
			context "with no matches" do
				it "sends a mark with ''" do
					game.start('1234')
					output.should_receive(:puts).with('0:0')
					game.guess('5678')
				end
			end

			context "with 1 number match" do
				it "sends a mark with '1:0'" do
					game.start('1234')
					output.should_receive(:puts).with('1:0')
					game.guess('2678')
				end
			end

			context "with 1 exact match" do
				it "sends a mark with '1:1'" do
					game.start('1234')
					output.should_receive(:puts).with('1:1')
					game.guess('1678')
				end
			end

			context "with 2 numbers match" do
				it "sends a mark with '2:0'" do
					game.start('1234')
					output.should_receive(:puts).with('2:0')
					game.guess('2378')
				end
			end

			context "with 1 exact match and 1 number match" do
				it "sends a mark with '2:1'" do
					game.start('1234')
					output.should_receive(:puts).with('2:1')
					game.guess('2537')
				end
			end
		end
	end
end
