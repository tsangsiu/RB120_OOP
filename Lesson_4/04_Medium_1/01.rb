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
  
Ben is correct.

`balance` on line 9 is actually is getter method as a result of line 2. The 
getter method returns the instance variable `@balance`.

=end
