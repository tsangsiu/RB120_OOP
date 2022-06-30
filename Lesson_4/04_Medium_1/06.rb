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

Function-wise, both class defintions are identical.

Syntax-wise, there are subtle differences:

Considering the `create_template` methods, both assign the String `"template 14231"`
to the instance variable `@template`. However, the first one do the assignment
directly to the instance variable, while the second one do so by calling the
setter method of `@template` provided by `attr_accessor :template`.

Considering the `show_template` methods, both are the same, where both refer to
the getter method of `@template` provided by `attr_accessor :template`. Just
that the `self.` in not necessary here.

=end
