module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

p Orange.ancestors
p HotSauce.ancestors

=begin
Lookup chain for `Orange`: Orange -> Taste -> Object -> Kernel -> BasicObject
Lookup chain for `HotSauce`: HotSauce -> Taste -> Object -> Kernel -> BasicObject
=end
