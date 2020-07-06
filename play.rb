require_relative 'robot'

class Play

  def initialize
      @robot = Robot.new
  end

  def execute(command)
    begin
      puts @robot.eval(command)
    rescue Exception => e
      puts e.message
    end
  end

end

#user input starts from here
s = Play.new
puts "Enter a Valid command"
command = STDIN.gets

while command
  command.strip!
  output = s.execute(command)
  puts output if output
  command = STDIN.gets
end