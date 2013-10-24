require 'rspec'
require File.dirname(__FILE__) + '/../lib/repairer'

describe Repairer do
  context "parsing" do
    let(:n) {3}
    let(:set) {"1 1 1
                1 1 1
                1 1 1"}

    it "should parse some data" do
      expect { Repairer.new(n, set) }.to_not raise_error
    end
  end

  context "internal methods (ack!)" do
    let(:repairer) { Repairer.new(3, "0 1 1
                                      0 1 1
                                      1 0 1")}

    context "sub-arrays" do
      it "should be able to tell me about the rows" do
        expect(repairer.send(:row, 0)).to eq([0, 1, 1])
      end

      it "should be able to tell me about the cols" do
        expect(repairer.send(:col, 0)).to eq([0, 0, 1])
      end
    end

    context "calculating weights" do
      it "should calculate the max weight" do
        expect(repairer.send(:max)).to eq([:col, 0])
      end

      it "should calculate the max row weight" do
        expect(repairer.send(:max_row)).to eq(0)
      end

      it "should calculate the max row weight" do
        expect(repairer.send(:max_col)).to eq(0)
      end

      it "should calculate weight of rows" do
        expect(repairer.send(:row_weight, 0)).to eq(1)
      end

      it "should calculate weight of cols" do
        expect(repairer.send(:col_weight, 0)).to eq(2)
      end
    end
  end

  context "fixing roads" do
    let(:repairer) { Repairer.new(3, "0 1 1
                                      0 1 1
                                      1 0 1")}

    xit "should output the method of fixing roads" do
      expect(repairer.data_to_s).to eq("X 1 1\nX 1 1\nX X X")
    end

    xit "should output the road map after fixing the roads" do
      expect(repairer.plan_to_s).to eq("Column 0 repaired.\nRow 2 repaired.")
    end
  end

  context "edge cases" do
    it "should fix road set 1" do
      { n: 5,
        repair: 4,
        data:
        "0 1 0 1 0
         1 0 0 0 1
         1 1 1 1 1
         1 0 0 0 1
         0 1 0 1 0"}
    end

    it "should fix road set 2" do
        { n: 9,
          repair: 0,
          data:
      "1 1 1 1 1 1 1 1 1
      2 2 2 2 2 2 2 2 2
      3 3 3 3 3 3 3 3 3
      4 4 4 4 4 4 4 4 4
      5 5 5 5 5 5 5 5 5
      6 6 6 6 6 6 6 6 6
      7 7 7 7 7 7 7 7 7
      8 8 8 8 8 8 8 8 8
      9 9 9 9 9 9 9 9 9"}
    end

    it "should fix road set 3" do
         { n: 7,
          repair: 3,
          data:
      "1 1 1 0 1 1 1
      2 2 2 0 2 2 2
      3 3 3 0 3 3 3
      4 0 4 0 4 0 4
      5 5 5 0 5 5 5
      6 6 6 0 6 6 6
      7 0 7 0 7 0 0"}
    end

    it "should fix road set 4" do
        { n: 9,
          repair: 3,
          data:
      "-1 -2 -3 -4 -5 -6 -7 -8 0
      12 9 8 7 6 4 1 8 9
      8 7 4 5 4 3 1 3 4
      10 20 30 40 50 60 70 80 90
      -90 -80 -70 -60 -50 -40 -30 -20 -10
      1 1 1 2 2 2 3 3 3
      4 4 4 5 5 5 6 6 6
      7 7 7 8 8 8 9 9 9
      0 2 2 -99 1 1 10 10 -2"}
    end

    it "should fix road set 5" do
        { n: 3,
          repair: 2,
          data:
      "0 1 1
      0 0 1
      1 0 1"}
    end

    it "should fix road set 6" do
        { n: 3,
          repair: 2,
          data:
      "1 1 1
      1 0 0
      0 0 1"}
    end

    it "should fix road set 7" do
        { n: 2,
          repair: 2,
          data:
      "-1 -1
      -1 -1"}
    end

    it "should fix road set 8" do
      { n: 1,
        repair: 0,
        data: "99"}
    end

    it "should fix road set 9" do
      { n: 1,
        repair: 1,
        data: "-13"}
    end

  end
end

