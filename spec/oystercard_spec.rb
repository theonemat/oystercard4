require 'oystercard'

describe Oystercard do

  let(:card) { described_class.new }

  it { is_expected.to respond_to(:balance) }

  describe '#top_up' do
    it 'balance can be topped up' do
      expect { card.top_up(10) }.to change{ card.balance }.by(10)
    end

    it 'fails if user tries to exceed maximum balance' do
      expect{ card.top_up(95) }.to raise_error("Maximum balance of #{Oystercard::MAX_BALANCE} exceeded")
    end
  end

  describe "#deduct" do
    it "deducts from the balance" do
      expect { card.deduct(10) }.to change{ card.balance }.by(-10)
    end
  end

end
