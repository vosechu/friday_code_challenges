require 'rspec'
require 'letter_press'

describe "Letter Press" do
  let(:lp) { LetterPress.new("k g d g i
                              e g v c y
                              o w g l b
                              s u i i l
                              a l v p o") }

  context "at/index" do
    it "should find index of row/col" do
      expect(lp.index(3, 3)).to eq(12)
    end
    it "should find letter at row/col" do
      expect(lp.at(3, 3)).to eq("g")
    end
  end

  context "paths" do
    it "should create words" do
      expect(lp.words(3)).to eq(["keg", "keg", "icy", "egg", "egg", "egg", "ego", "owe", "wig", "woe", "wog", "guv", "lib", "lip", "lii", "lii", "lip", "big", "bio", "sow", "sou", "ill", "ill", "ill", "lop", "lib", "lip", "lii", "lug", "lii", "lip", "lvi", "lvi", "vii", "vii", "pig", "pig", "poi", "pol", "oil", "oil"])
    end

    it "should create all paths" do
      expect(lp.send(:all_paths, 1)).to eq([[0, 1], [0, 6], [0, 5], [1, 2], [1, 7], [1, 6], [1, 5], [1, 0], [2, 3], [2, 8], [2, 7], [2, 6], [2, 1], [3, 4], [3, 9], [3, 8], [3, 7], [3, 2], [4, 9], [4, 8], [4, 3], [5, 0], [5, 1], [5, 6], [5, 11], [5, 10], [6, 0], [6, 1], [6, 2], [6, 7], [6, 12], [6, 11], [6, 10], [6, 5], [7, 1], [7, 2], [7, 3], [7, 8], [7, 13], [7, 12], [7, 11], [7, 6], [8, 2], [8, 3], [8, 4], [8, 9], [8, 14], [8, 13], [8, 12], [8, 7], [9, 3], [9, 4], [9, 14], [9, 13], [9, 8], [10, 5], [10, 6], [10, 11], [10, 16], [10, 15], [11, 5], [11, 6], [11, 7], [11, 12], [11, 17], [11, 16], [11, 15], [11, 10], [12, 6], [12, 7], [12, 8], [12, 13], [12, 18], [12, 17], [12, 16], [12, 11], [13, 7], [13, 8], [13, 9], [13, 14], [13, 19], [13, 18], [13, 17], [13, 12], [14, 8], [14, 9], [14, 19], [14, 18], [14, 13], [15, 10], [15, 11], [15, 16], [15, 21], [15, 20], [16, 10], [16, 11], [16, 12], [16, 17], [16, 22], [16, 21], [16, 20], [16, 15], [17, 11], [17, 12], [17, 13], [17, 18], [17, 23], [17, 22], [17, 21], [17, 16], [18, 12], [18, 13], [18, 14], [18, 19], [18, 24], [18, 23], [18, 22], [18, 17], [19, 13], [19, 14], [19, 24], [19, 23], [19, 18], [20, 15], [20, 16], [20, 21], [21, 15], [21, 16], [21, 17], [21, 22], [21, 20], [22, 16], [22, 17], [22, 18], [22, 23], [22, 21], [23, 17], [23, 18], [23, 19], [23, 24], [23, 22], [24, 18], [24, 19], [24, 23]])
    end

    it "should create paths recursively" do
      expect(lp.send(:paths, 0, 1)).to eq([[0, 1], [0, 6], [0, 5]])
    end

    it "should create paths without very short cycles" do
      # This would normally have [0, 1, 0] without short cycle detection
      expect(lp.send(:paths, 0, 2)).to eq([[0, 1, 2], [0, 1, 7], [0, 1, 6], [0, 1, 5], [0, 6, 1], [0, 6, 2], [0, 6, 7], [0, 6, 12], [0, 6, 11], [0, 6, 10], [0, 6, 5], [0, 5, 1], [0, 5, 6], [0, 5, 11], [0, 5, 10]])
    end
  end

  context "neighbors" do
    it "should return the index of all neighbors for the normal case" do
      expect(lp.send(:neighbor_indexes, lp.index(3,3))).to eq([6, 7, 8, 13, 18, 17, 16, 11])
    end
    it "should return all neighbors for the normal case" do
      expect(lp.send(:neighbors, lp.index(3,3))).to eq(%w{g v c l i i u w})
    end
    it "should return the indexes of upper left" do
      expect(lp.send(:neighbor_indexes, lp.index(1,1))).to eq([1,6,5])
    end
    it "should return upper left" do
      expect(lp.send(:neighbors, lp.index(1,1))).to eq(%w{g g e})
    end
    it "should return upper right" do
      expect(lp.send(:neighbors, lp.index(5,1))).to eq(%w{y c g})
    end
    it "should return lower left" do
      expect(lp.send(:neighbors, lp.index(1,5))).to eq(%w{s u l})
    end
    it "should return lower right" do
      expect(lp.send(:neighbors, lp.index(5,5))).to eq(%w{i l p})
    end
    it "should return left side" do
      expect(lp.send(:neighbors, lp.index(1,3))).to eq(%w{e g w u s})
    end
    it "should return right side" do
      expect(lp.send(:neighbors, lp.index(5,3))).to eq(%w{c y l i l})
    end
    it "should return upper side" do
      expect(lp.send(:neighbors, lp.index(3,1))).to eq(%w{g c v g g})
    end
    it "should return lower side" do
      expect(lp.send(:neighbors, lp.index(3,5))).to eq(%w{u i i p l})
    end
  end
end