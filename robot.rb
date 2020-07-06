class Robot
  attr_reader :position, :direction, :rows, :columns

  FACINGS = [:north, :east, :south, :west]
  COMMANDS = [:place, :move, :left, :right, :report]
   

  def initialize
    @rows = 5
    @columns = 5
  end


  def place(x, y, direction)
    raise 'Coordinates are not valid' unless x.is_a? Integer and y.is_a? Integer
    raise 'Directions are not valid' unless FACINGS.include?(direction)

    if valid_position?(x, y)
      @position = { x: x, y: y }
      @direction = direction
      true
    else
      false
    end

  end

  #input command 'move' execution
  def move
    return false if @position.nil?
    position = @position
    movement = case @direction
               when :north
                { x: 0, y: 1}
               when :east
                { x: 1, y: 0}
               when :south
                { x: 0, y: -1}
               when :west
                { x: -1, y: 0}
               end
    moved = true

    if valid_position?(position[:x] + movement[:x], position[:y] + movement[:y])
      @position = { x: position[:x] + movement[:x], y: position[:y] + movement[:y] }
    else
      moved = false
    end
    moved
  end

 #for left input command
  def left
    return false if @direction.nil?
    i = FACINGS.index(@direction)
    @direction = FACINGS.rotate(-1)[i]
    true
  end

  
 #for right input command 
  def right
    return false if @direction.nil?
    i = FACINGS.index(@direction)
    @direction = FACINGS.rotate()[i]
    true
  end

  #for report input command 
  def report
    return "Board error" if @position.nil? or @direction.nil?
    "#{@position[:x]},#{@position[:y]},#{@direction.to_s.upcase}"
  end

  #command execution
  def eval(input)
    return if input.strip.empty?

    args = input.split(/\s+/)
    command = args.first.to_s.downcase.to_sym
    arguments = args.last

    raise 'Wrong command' unless COMMANDS.include?(command)

    case command
    when :place
      raise 'Wrong command' if arguments.nil?
      input_cds = arguments.split(/,/)
      raise  'Wrong command' unless input_cds.count > 2

      x = input_cds[0].to_i
      y = input_cds[1].to_i
      direction = input_cds[2].downcase.to_sym

      place(x, y, direction)
    when :move
      move
    when :left
      left
    when :right
      right
    when :report
      report
    else
      raise 'Wrong command'
    end

  end

  private

  def valid_position?(x, y)
    (x >= 0 && x <= columns && y >= 0 && y <= rows)
  end

end