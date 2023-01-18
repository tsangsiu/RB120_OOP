class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
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
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post

=begin
On line 45, when the `puts` method is invoked with the argument `blog_post`, the
`to_s` method is implicitly called on `blog_post`, returning `#{name}.#{FORMAT}`.
To resolve the constant `FORMAT`, Ruby first looks for it in its surrounding
structure. The constant is not found in the `to_s` method or the `File` class, 
Ruby then looks for it up in the method lookup path, and finally in the main
scope. As the constant is still not found, Ruby raises `NameError`.

To resolve the problem, we can specifically specify where to look for the
constant, like so:
`"#{name}.#{self.class::FORMAT}"`
=end
