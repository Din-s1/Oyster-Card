In order to use public transport
As a customer
I want money on my card

in irb
  load './lib/oystercard.rb'
  oyster = Oystercard.new
  oyster.balance == 0


In order to keep using public transport
As a customer
I want to add money to my card

in irb
  load './lib/oystercard.rb'
  oyster = Oystercard.new
  oyster.top_up(2)
  oyster.balance == 2

In order to protect my money from theft or loss
As a customer
I want a maximum limit (of £90) on my card

in irb
  load './lib/oystercard.rb'
  oyster = Oystercard.new(90)
  oyster.top_up(1)
  --> raise exception

In order to pay for my journey
As a customer
I need my fare deducted from my card

in irb
  load './lib/oystercard.rb'
  oyster = Oystercard.new(10)
  oyster.deduct(5)
  oyster.balance == 5

In order to get through the barriers.
As a customer
I need to touch in and out.

in irb
  load './lib/oystercard.rb'
  oyster = Oystercard.new(10)
  oyster.in_journey? == false
  oyster.touch_in
  oyster.in_journey? == true
  oyster.touch_out
  oyster.in_journey? == false
