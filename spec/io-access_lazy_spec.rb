require File.expand_path('../spec_helper', __FILE__)

describe IO::AccessLazy do
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
