require 'bigdecimal'
BigDecimal.limit(10) # Limit the accuracy of BigDecimal calculations

class Sum
  def initialize(steps)
    @total = 0
    steps.times do |i|
      @total += sum(i)
    end
  end

  def sum(step)
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