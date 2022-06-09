class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

=begin

When the method `update_quantity` is called, what Alan intends to do is to
update the instance variable `@quantity` by `updated_count`. However, `quantity`
on line 11 is an initialisation of a local variable.

To address the issue, we can either:
  - add a setter method for `@quantity` by adding a line `attr_writer :quantity`,
    and call the setter method on line 11 by `self.quantity`, or
  - prepending `quantity` by an `@`.

=end
