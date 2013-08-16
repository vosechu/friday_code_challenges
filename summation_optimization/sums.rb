require 'bigdecimal'

# Limit the accuracy of BigDecimal calculations
# It's worth noting that BigDecimal does have a limit on precision so
# if you try to add two very large numbers, the last digits will always
# be incorrect. For example: 023456789E101 + 100000000E100 == 1234567899E101
BigDecimal.limit(10)

class Sum
  def initialize(steps)
    @totals = []
    steps.times do |i|
      @totals[i] = sum(i)
    end
    @total = @totals.reduce(:+)
  end

  def sum(step)
    if @totals[step-1]
      return @totals[step-1] * step
    end
    sum = BigDecimal.new("1")
    step.times do |i|
      sum *= BigDecimal.new(i+1)
    end
    return sum
  end

  def to_s
    @total.to_s
  end
end

require 'rspec/autorun'

describe "Sum" do
  before(:each) do
    @sum = Sum.new(1)
  end

  it "should sum a number" do
    @sum.sum(1).should eq(1)
    @sum.sum(2).should eq(2)
    @sum.sum(3).should eq(6)
    @sum.sum(4).should eq(24)
    @sum.sum(5).should eq(120)
  end

  it "should calculate large numbers" do
    @sum.sum(50).should_not eq(@sum.sum(51))
    @sum.sum(500).should_not eq(@sum.sum(501))
  end

  it "should calculate a total" do
    @sum = Sum.new(3)
    str = (@sum.sum(2) + @sum.sum(1) + @sum.sum(0)).to_s
    @sum.to_s.should eq(str)
  end

  it "should calculate a large total" do
    @sum = Sum.new(50)
    @sum.to_s.should eq("0.6209600292E63")
  end
end