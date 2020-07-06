require_relative 'robot'

describe Robot do

  before(:each) do
    @robot = Robot.new
  end

  it 'robot in right place' do
    expect(@robot.place(0, 1, :north)).to eq(true)
    expect(@robot.place(5, 5, :north)).to eq(true)
    expect(@robot.place(6, 6, :west)).to eq(false)
  end

  it 'First input should pass' do
    @robot.place(0, 0, :north)
    expect(@robot.move).to eq(true)
    expect(@robot.position[:x]).to eq(0)
    expect(@robot.position[:y]).to eq(1)
    expect(@robot.direction).to eq(:north)
  end

  it 'Second input should pass' do
    @robot.place(0, 0, :north)
    @robot.left
    @robot.report
    expect(@robot.position[:x]).to eq(0)
    expect(@robot.position[:y]).to eq(0)
    expect(@robot.direction).to eq(:west)
  end

  it 'Third input should pass' do
    @robot.place(1, 2, :east)
    @robot.move
    @robot.move
    @robot.left
    @robot.move
    @robot.report
    expect(@robot.position[:x]).to eq(3)
    expect(@robot.position[:y]).to eq(3)
    expect(@robot.direction).to eq(:north)

  end

  it 'should rotate right' do
    @robot.place(0, 0, :north)
    @robot.right
    expect(@robot.direction).to eq(:east)
    @robot.right
    expect(@robot.direction).to eq(:south)
  end

  it 'should rotate left' do
    @robot.place(0, 0, :north)
    @robot.left
    expect(@robot.direction).to eq(:west)
    @robot.left
    expect(@robot.direction).to eq(:south)
  end


  it 'should report position' do
    @robot.place(5, 5, :east)
    expect(@robot.report).to eq("5,5,EAST")
    @robot.move 
    expect(@robot.report).to eq("5,5,EAST")
  end
 

end