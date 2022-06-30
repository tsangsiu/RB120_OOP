class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

=begin
  
Ben is right.

`balance` on line 9 refers to the getter method of the instance variable
`@balance`. The method returns the instance variable `@balance`, and is provided
by the `attr_reader` on line 2.

=end
