class Pacman
  attr_reader :position, :dots

  def initialize
    @position = rand(16)
    @dots = "x"*16
    @dots[@position] = " "
  end

  def eat_dot
    @dots[@position] = " "
    puts @dots
  end

  def move_left
    eat_dot
    @position -= 1
  end

  def move_right
    eat_dot
    @position += 1
  end

  def score
    @dots.count(" ")
    # start of pacman is no point
  end

end
