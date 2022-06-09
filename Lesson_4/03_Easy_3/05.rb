class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer # => NoMethodError
tv.model # => returns the return value of the `Television#model` method

Television.manufacturer # => returns the return value of the `Television::manufacturer` method
Television.model # => NoMethodError
