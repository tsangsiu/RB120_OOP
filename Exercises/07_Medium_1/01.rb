class Machine
  def start
    # The self. here refer to an instance of the class.
    # After the method `flip_switch` is made private,
    # `self.flip_switch` will raise `NoMethodError`.
    # For the method to work, `self.` should be removed.

    # The caller is not necessary but is accepted when `flip_switch` is public,
    # but it is prohibited when `flip_switch` is private.

    # As of Ruby 2.7, it is acceptable to call a private method with `self.`.

    # self.flip_switch(:on)
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end
  
  def status
    switch
  end

  private

  attr_accessor :switch

  def flip_switch(desired_state)
    # But here, `self.` is necessary.
    # Otherwise, Ruby will treat it as a local variable.
    
    self.switch = desired_state
  end
end

machine = Machine.new
machine.start
p machine.status
