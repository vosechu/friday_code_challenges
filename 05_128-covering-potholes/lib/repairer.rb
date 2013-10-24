# Long-form response to http://www.reddit.com/r/dailyprogrammer/comments/1g7gyi/061213_challenge_128_intermediate_covering/
# Once we have this we'll make it terrible!

class Repairer
  def initialize(num_rows, data)
    @num_rows = num_rows
    @data = parse(data)
  end

  def to_s
    return <<-EOS
Plan:
  #{data_to_s}
Map:
  #{plan_to_s}
EOS
  end

  def data_to_s
    repair.map {|row| row.join(" ") }.join("\n")
  end

  def plan_to_s
    "Row 0 repaired.
     Row 2 repaired.
     Row 4 repaired.
     Column 2 repaired."
  end

  def repair
    data # Return fixed data
  end

  private

    # Accessors ====================================================== #
    def data
      @data
    end

    def num_rows
      @num_rows
    end

    # Manipulations ================================================== #
    def parse(data)
      data.split("\n").map {|r| r.split.map! {|i| i.to_i} }
    end

    def fix_row(index)

    end

    def fix_col(index)

    end

    # Calculators ==================================================== #
    def row(index)
      data[index]
    end

    def col(index)
      result = []
      num_rows.times do |i|
        result << data[i][index]
      end
      result
    end

    def row_weight(index)
      1
    end

    def col_weight(index)
      2
    end

    def max_row
      0 # Returns index of max row
    end

    def max_col
      0 # Returns index of max col
    end

    def max
      [:col, 0] # (max_col >= max_row) ? [:col, max_col] : [:row, max_row]
    end
end

# def repair(set)
#   n = set[:n]
#   set[:data] = parse(set[:data])
#   repair_column_counts = []
#   repair_row_counts = []

# puts "Data: " + set[:data].inspect
# puts "Row 0 " + row(set, 0).inspect
#   n.times do |i|
#     repair_row_counts << [i, row(set, i).reject {|num| num > 0}.count]
#     repair_column_counts << [i, column(set, i).reject {|num| num > 0}.count]
#   end


#   puts "end data " + set[:data].inspect
#   puts "repair rows " + repair_row_counts.inspect
#   puts "repait cols " + repair_column_counts.inspect

# end
