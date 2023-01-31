class Minilang
  def initialize(program)
    @program = program
  end

  def eval
    @tokens = @program.split
    @stack = []
    @register = 0

    @tokens.each do |token|
      if token =~ /\A[-+]?\d+\z/
        @register = token.to_i
      else
        execute(token)
      end
    end
  end

  private

  def execute(token)
    begin
      send(token.downcase.to_sym)
    rescue NoMethodError
      puts "Invalid token: #{token}"
    end
  end

  def print
    puts @register
  end

  def push
    @stack << @register
  end

  def mult
    @register *= @stack.pop
  end

  def add
    @register += @stack.pop
  end

  def sub
    @register -= @stack.pop
  end

  def div
    @register /= @stack.pop
  end

  def mod
    @register %= @stack.pop
  end

  def pop
    begin
      @register = @stack.fetch(-1)
      @stack.pop
    rescue IndexError
      puts "Empty stack!"
    end
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
