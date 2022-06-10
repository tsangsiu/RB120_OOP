class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231" ###
  end

  def show_template
    template ### 
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231" ###
  end

  def show_template
    self.template ###
  end
end

=begin

What is the difference in the way the code works?

The first difference is in the `create_template` method. In the first one, the 
instance variable is assigned to the value directly, while in the second one,
the instance variable is assigned through the setter method.

The second difference is in the `show_template` method. One with `self`, while 
the other without. They are identical in terms of what they do. They are both
the getter method of the `template` instance variable. Just that the latter is
more explicit that the `template` method is called on a `Computer` object. The
`self` is not necessary in this case.

=end
