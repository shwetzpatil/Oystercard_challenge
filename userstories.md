In order to use public transport
As a customer
I want money on my card

in irb
require './lib/oystercard.rb'
test = Oystercard.new
test.balance == 0

In order to keep using public transport
As a customer
I want to add money to my card

in irb
require './lib/oystercard.rb'
test = Oystercard.new
amount = 10
test.top_up(amount)
test.balance == amount
