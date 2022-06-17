class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-#{'-' * @message.length}-+"
  end

  def empty_line
    "| #{' ' * @message.length} |"
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner = Banner.new('')
puts banner

=begin

# Further Exploration

Modify this class so new will optionally let you specify a fixed banner width at
the time the Banner object is created. The message in the banner should be
centered within the banner of that width. Decide for yourself how you want to
handle widths that are either too narrow or too wide.

# Algorithm

- If the specified width is longer than the message's length,
  - Put the message in the center
- Else if the specified width is shorter than the message's length,
  - Split the message into chunks of the specified width
  - Output each chunk on each line in the center

- Find the index of the last occurrence
str = "I go to school by bus"
str_reverse = "sub yb loohcs ot og I"
str_reverse.index(' ') -> 3
str.length - str_reverse.index(' ') - 1 -> 17

=end

class Message
  attr_accessor :message

  def initialize(msg)
    self.message = msg
  end
  
  def to_s
    message
  end
  
  def last_index(char)
    self.to_s.length - self.to_s.reverse.index(' ') - 1
  end
  
  def index(char)
    self.to_s.index(char)
  end
  
  def length
    self.to_s.length  
  end
  
  def slice(range)
    Message.new(self.to_s[range])
  end

  def center(width)
    self.to_s.center(width)
  end

  def split(max_length)
    chunks = []
    message_to_split = self.clone

    while message_to_split.length > max_length
      if message_to_split.slice(0...max_length).index(' ')
        end_index = message_to_split.slice(0...max_length).last_index(' ')
        chunks << message_to_split.slice(0...end_index)
        message_to_split = message_to_split.slice((end_index + 1)..)
      else
        end_index = max_length - 1
        chunks << Message.new("#{message_to_split.slice(0...end_index)}-")
        message_to_split = Message.new("#{message_to_split.slice(end_index..)}")
      end
    end
    chunks << message_to_split

    chunks
  end
end

class Banner2
  attr_reader :message, :banner_width
  
  def initialize(message, banner_width = message.length + 4)
    self.message = Message.new(message)
    self.banner_width = banner_width
  end
  
  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end
  
  private
  
  attr_writer :message, :banner_width
  
  def content_width
    banner_width - 4
  end
  
  def horizontal_rule
    "+-#{'-' * content_width}-+"
  end

  def empty_line
    "| #{' ' * content_width} |"
  end

  def message_line
    if message.length <= content_width
      "| #{message.center(content_width)} |"
    else
      message.split(content_width).map do |chunk|
        "| #{chunk.center(content_width)} |"
      end
    end
  end
end

banner = Banner2.new('To boldly go where no one has gone before.')
puts banner

banner = Banner2.new('')
puts banner

banner = Banner2.new('To boldly go where no one has gone before.', 20)
puts banner

banner = Banner2.new('You are supercalifragilisticexpialidocious!', 25)
puts banner
