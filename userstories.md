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

In order to protect my money from theft or loss
As a customer
I want a maximum limit (of £90) on my card

in irb
require './lib/oystercard.rb'
test = Oystercard.new
amount = 90
test.top_up(amount)
test.top_up(0.01)    #should raise error

In order to pay for my journey
As a customer
I need my fare deducted from my card
require './lib/oystercard.rb'
test = Oystercard.new
test.top_up(90)
test.ticket_fare(10)
test.balance == 80

In order to get through the barriers.
As a customer
I need to touch in and out.

in irb
require './lib/oystercard.rb'
test = Oystercard.new
test.in_journey? == false
test.touch_in
test.in_journey? == true
test.touch_out
test.in_journey? == false

In order to pay for my journey
As a customer
I need to have the minimum amount (£1) for a single journey.
in irb
require './lib/oystercard.rb'
test = Oystercard.new
test.top_up(1)
test.touch_in
test.ticket(1)
test.touch_out

test.balance == 0
test.touch_in #raise error

In order to pay for my journey
As a customer
When my journey is complete, I need the correct amount deducted from my card

in irb
require './lib/oystercard.rb'
test = Oystercard.new
test.top_up(3)
test.touch_out
test.balance == 1


In order to pay for my journey
As a customer
I need to know where I've travelled from

in irb
require './lib/oystercard.rb'
test = Oystercard.new
starting_station = Station.new("zone1")
test.touch_in
test.starting_station == "zone1"
