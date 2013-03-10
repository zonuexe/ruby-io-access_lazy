require File.expand_path('../spec_helper', __FILE__)

describe IO::AccessLazy do
  describe '#[]' do
    let(:sample){ str = <<-EOT
A
B
C
D
E
F
G
      EOT
      return IO::AccessLazy.new(str)
    }
    it{ expect(sample).to be_a IO::AccessLazy }
    it{ expect(sample[0]).to eq "A\n" }
    it{ expect(sample[2..3]).to eq ["C\n", "D\n"] }
    it{ expect(sample[4..-1]).to eq ["E\n", "F\n", "G\n"] }
  end
  describe '.check_range' do
    context 'lower limit is 0' do
      it{ expect(IO::AccessLazy.check_range(0..0)).to be_true }
      it{ expect(IO::AccessLazy.check_range(0..-1)).to be_true }
      it{ expect(IO::AccessLazy.check_range(0..10)).to be_true }
    end

    context 'lower limit is negative' do
      it{ expect(IO::AccessLazy.check_range(-1..0)).to be_false }
      it{ expect(IO::AccessLazy.check_range(-3..5)).to be_false }
    end

    context 'upper limit is negative' do
      it{ expect(IO::AccessLazy.check_range(0..-5)).to be_false }
      it{ expect(IO::AccessLazy.check_range(-1..-1)).to be_false }
    end

    context 'lower limit is greater than upper limit' do
      it{ expect(IO::AccessLazy.check_range(10..5)).to be_false }
      it{ expect(IO::AccessLazy.check_range(8..0)).to be_false }
    end
  end
end
