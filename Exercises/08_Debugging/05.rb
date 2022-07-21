class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  # to alias `read`/`write` to `byte_content`/`byte_content=` inside the `File` class
  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read) # the method `read` returns the byte contents 

    target_file # returns a MarkdownFile object
  end

  def to_s
    "#{name}.#{self.class::FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes) # calling the setter of the instance variable @byte_content
# the `bytes` method returns the array of ASCII code of characters

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post # => (expected) Adventures_in_OOP_Land.md
