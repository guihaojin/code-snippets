class MazeSolver

  def initialize(input_filename)
    read_input(input_filename)
    find_start_end
  end

  def read_input(filename)
    @maze = Array.new
    File.readlines(filename).each do |line|
      a_line = []
      line.strip.each_char { |c| a_line << c }
      @maze << a_line
    end
  end

  def find_start_end
    @maze.each_with_index do |row, i|
      row.each_with_index do |e, j|
        if e == 'X'
          @start_position = [i, j]
        end
        if e == 'O'
          @end_position = [i, j]
        end
        return if @start_position && @end_position
      end
    end
  end

  def breadth_first_search
    @paths = {}
    @queue = []
    @queue << @start_position
    @paths[@start_position] = nil
    while !@queue.empty? do
      x, y = @queue.shift
      if [x, y] == @end_position
        fill_path
        return
      end
      process(x - 1, y, [x, y])
      process(x + 1, y, [x, y])
      process(x, y + 1, [x, y])
      process(x, y - 1, [x, y])
    end
    puts @paths
  end

  def process(x, y, parent)
    if x >= 0 && x < @maze.size &&
       y >= 0 && y < @maze[0].size &&
       @maze[x][y] != '#' && !@paths.include?([x, y])
      @paths[[x, y]] = parent
      @queue << [x, y]
    end
  end

  def fill_path
    temp = @end_position
    while temp do
      @maze[temp[0]][temp[1]] = '+'
      temp = @paths[temp]
    end
  end

  def print_maze
    @maze.each do |row|
      puts row.join
    end
  end

end

solver = MazeSolver.new("maze.txt")
solver.breadth_first_search
solver.print_maze
