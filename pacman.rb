class Pacman
  attr_reader :position, :dots

  def initialize
    @position = Kernel.rand(16)
    @dots = "x"*16
  end

  def eat_dot
    @dots[@position] = " "
    puts @dots
  end

  def move_left
    eat_dot
    @position = (@position - 1) % 16
  end

  def move_right
    eat_dot
    @position = (@position + 1) % 16
  end

  def score
    @dots.count(" ")
  end

  def state
    "running"
  end



end
