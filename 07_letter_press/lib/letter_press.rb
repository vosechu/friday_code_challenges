require 'ffi/aspell'

class LetterPress
  def initialize(puzzle)
    @puzzle = puzzle
    @graph = parse(puzzle)
    @row_len = Math.sqrt(@graph.length).to_i

    @speller = FFI::Aspell::Speller.new('en_US')
  end

  def solve(upto=6)
    (2..upto).to_a.each do |i|
      puts "******** #{i} letter words ********"
      puts lp.words(i)
    end
  end

  def words(count)
    w = []
    all_paths(count-1).each do |path|
      w << path.map {|index| self[index]}.join
    end
    w = w.uniq

    return w.select {|word| @speller.correct?(word)}
  end

  private

    DIRECTIONS = [:north_west, :north, :north_east, :east, :south_east, :south, :south_west, :west]

    # Parsers ======================================================== #

    def parse(puzzle)
      return puzzle.split("\n").map {|line| line.split(" ")}.flatten
    end

    # Conditionals =================================================== #

    def has_east?(index)
      ![4, 9, 14, 19, 24].include?(index)
    end
    def has_west?(index)
      ![0, 5, 10, 15, 20].include?(index)
    end
    def has_south?(index)
      ![20, 21, 22, 23, 24].include?(index)
    end
    def has_north?(index)
      ![0, 1, 2, 3, 4].include?(index)
    end

    # Calculations =================================================== #

    def all_paths(count=3)
      p = []
      @graph.length.times do |i|
        p += paths(i, count)
      end
      return p.uniq
    end

    def paths(index, count=3, past=nil)
      if count <= 0
        return [index]
      else
        all_paths = []
        neighbor_indexes(index).each do |neighbor|
          paths(neighbor, count-1, index).each do |path|
            if path.is_a? Fixnum
              next if path == past # prevent very short cycles
              all_paths << [index, path]
            else
              all_paths << path.unshift(index)
            end
          end
        end
        return all_paths
      end
    end

    def neighbors(index)
      adj = []
      DIRECTIONS.each do |dir|
        adj << self[self.send(dir, index)]
      end
      return adj.reject(&:nil?)
    end
    def neighbor_indexes(index)
      adj = []
      DIRECTIONS.each do |dir|
        adj << self.send(dir, index)
      end
      return adj.reject(&:nil?)
    end

    # Accessors ====================================================== #

    def at(col, row)
      self[index(col, row)]
    end
    def index(col, row)
      return (row - 1) * @row_len + (col - 1)
    end

    def [](index)
      return nil if index.nil?
      return @graph[index]
    end

    def north(index)
      index - @row_len if has_north?(index)
    end
    def south(index)
      index + @row_len if has_south?(index)
    end
    def east(index)
      index + 1 if has_east?(index)
    end
    def west(index)
      index - 1 if has_west?(index)
    end
    def north_east(index)
      if north(index) && has_east?(index)
        north(index) + 1
      end
    end
    def north_west(index)
      if north(index) && has_west?(index)
        north(index) - 1
      end
    end
    def south_east(index)
      if south(index) && has_east?(index)
        south(index) + 1
      end
    end
    def south_west(index)
      if south(index) && has_west?(index)
        south(index) - 1
      end
    end

end