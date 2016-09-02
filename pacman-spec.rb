require "./pacman"

describe Pacman do
  it "the board has 16 dots" do
    expect(Pacman.new.dots.length).to eq 16
  end

  it "should tell pacman's position on the board" do
    expect(Pacman.new.position).to be >= 0
  end

  it "has pacman not off the board" do
    expect(Pacman.new.position).to be < 16
  end

  it "should have a different position each time" do
    old_position = Pacman.new.position
    expect(Pacman.new.position).to_not eq old_position
  end

  it "moves Pacman left" do
    pacman = Pacman.new
    old_position = pacman.position
    pacman.move_left
    expect(pacman.position).to eq old_position - 1
  end

  it "moves right" do
    pacman = Pacman.new
    old_position = pacman.position
    pacman.move_right
    expect(pacman.position).to eq old_position + 1
  end

  it "Pacman starts with a score of 0" do
    pacman = Pacman.new
    expect(pacman.score).to eq 0
  end

  it "gains a point when it moves left" do
    pacman = Pacman.new
    pacman.move_left
    expect(pacman.score).to eq 1
  end

  it "gains a point when it moves right" do
    pacman = Pacman.new
    pacman.move_right
    expect(pacman.score).to eq 1
  end

  it "dots get eaten when moving right" do
    pacman = Pacman.new
    original_position = pacman.position
    pacman.move_right
    expect(pacman.dots[original_position]).to eq " "
  end

  it "still has uneaten dots at unvisited positions" do
    pacman = Pacman.new
    original_position = pacman.position
    pacman.move_right
    expect(pacman.dots[pacman.position]).to eq "x"
  end

  it "gains a point when goes back and forth" do
    pacman = Pacman.new
    pacman.move_right
    pacman.move_left
    expect(pacman.score).to eq 1
  end

end
