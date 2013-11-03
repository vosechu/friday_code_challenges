require 'rspec'
require 'letter_press'

describe "Letter Press" do
  let(:lp) { LetterPress.new("k g d g i
                              e g v c y
                              o w g l b
                              s u i i l
                              a l v p o") }

  it "should create words" do
    expect(lp.words(2)).to eq(["kg", "kc", "kw", "kl", "ks", "go", "gs", "dc", "do", "db", "id", "iv", "is", "ii", "ed", "es", "ea", "vi", "vb", "vs", "ck", "cg", "co", "cw", "cl", "cs", "cu", "ca", "yd", "ye", "yo", "ya", "oi", "ow", "ob", "op", "wk", "we", "lg", "lo", "lb", "ls", "ll", "la", "bk", "bi", "be", "by", "bl", "bu", "so", "us", "up", "ad", "av", "ac", "aw", "ab", "as", "pk", "pg", "pd", "pi", "pl", "pa"])
  end

  context "paths" do
    it "should create all paths" do
      expect(lp.send(:all_paths, 1)).to include([12,13])
    end

    it "should not create duplicates" do
      expect(lp.send(:all_paths, 1)).to_not include([12,12])
    end

    it "should create paths recursively" do
      expect(lp.send(:paths, 0, 1)).to eq([[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [0, 8], [0, 9], [0, 10], [0, 11], [0, 12], [0, 13], [0, 14], [0, 15], [0, 16], [0, 17], [0, 18], [0, 19], [0, 20], [0, 21], [0, 22], [0, 23], [0, 24]])
    end

    it "should create paths without very short cycles" do
      # This would normally have [0, 1, 0] without short cycle detection
      expect(lp.send(:paths, 0, 2)).to_not include([0, 1, 0])
    end
  end

  context "neighbors" do
    it "should return the index of all neighbors for the normal case" do
      expect(lp.send(:neighbor_indexes, lp.send(:index,1,1))).to eq((0..24).to_a - [0])
    end
  end
end