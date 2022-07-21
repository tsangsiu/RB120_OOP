class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if amount <= balance
      success = (self.balance -= amount) # truthy
    else
      success = false
    end

    if success
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  # setter methods always return the assigned value
  def balance=(new_balance)
    if valid_transaction?(new_balance)
      @balance = new_balance
      true
    else
      false
    end
  end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
                          # Actual output: $80 withdrawn. Total balance is $50.
p account.balance         # => 50

# Further Exploration

# What will the return value of a setter method be if you mutate its argument in the method body?

# Example 1

class Number
  attr_reader :number

  def initialize(number)
    @number = number
  end
  
  def number=(number)
    @number = number
    number += 1
  end
  
  def to_s
    "#{number}"
  end
end

# As integers are immutable in Ruby, I would expect the following outputs `0` to the console.
puts Number.new(1).number = 0

# Example 2

class Name
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def name=(name)
    @name = name
    name.downcase!
  end

  def to_s
    @name
  end
end

puts Name.new('Jason').name = 'JT' # => 'jt'
