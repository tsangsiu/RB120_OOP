class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

=begin

That could be a problem. Because by doing so, we can bypass the
`update_quantity` method, and update the quantity directly by
`instance.quantity = <new value>`. That means the new value would not go through
the logic check in `update_quantity`.

=end
