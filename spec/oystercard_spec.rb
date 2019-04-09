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

  describe '#in_journey?' do
    it "checks if card is in journey" do
      expect(card).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it "changes in_journey to true" do
      card.top_up(2)
      expect(card.touch_in).to eq true
    end
    it "it raises an error when less than £1" do
      expect { card.touch_in }.to raise_error 'minimum balance required'
    end
  end

  describe '#touch_out' do
    it "changes in_journey to false" do
      expect(card.touch_out).to eq false
    end
  end
end
