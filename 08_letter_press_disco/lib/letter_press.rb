require 'ffi/aspell'

# Bugs:
# Sometimes uses the same letter twice (cycle)
# Should use a smaller dictionary
# Features:
# Use the 12dict dictionary or a scrabble dictionary (<10k words)
# Target certain letters and avoid other letters

class LetterPress
  def initialize(puzzle, good_letters, bad_letters)
    @puzzle = puzzle
    @graph = parse(puzzle)
    @row_len = Math.sqrt(@graph.length).to_i

    @speller = FFI::Aspell::Speller.new('en_US')
    @speller.suggestion_mode = 'ultra'
  end

  def solve(upto=6)
    (2..upto).to_a.each do |i|
      puts "******** #{i} letter words ********"
      puts lp.words(i)
    end
  end

  def words(count)
    w_paths = []
    all_paths(count-1).each do |path|
      w_paths << path.map {|index| self[index]}.join
    end
    w_paths = w_paths.uniq

    results = []
    w_paths.each do |word|
      if @speller.correct?(word)
        results << word
        puts word
      end
    end
    return results.uniq
  end

  private

    # Parsers ======================================================== #

    def parse(puzzle)
      return puzzle.split("\n").map {|line| line.split(" ")}.flatten
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

    def neighbor_indexes(index)
      return (0..24).to_a - [index]
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

end