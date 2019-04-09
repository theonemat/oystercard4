require 'oystercard'

describe Oystercard do

  let(:card) { described_class.new }
  let(:entry_station) { double(:station) }

  it { is_expected.to respond_to(:balance) }

  describe '#top_up' do
    it 'balance can be topped up' do
      expect { card.top_up(10) }.to change{ card.balance }.by(10)
    end

    it 'fails if user tries to exceed maximum balance' do
      max_balance = Oystercard::MAX_BALANCE
      expect{ card.top_up(95) }.to raise_error("Maximum balance of #{max_balance} exceeded")
    end
  end
=begin
  describe "#deduct" do
    it "deducts from the balance" do
      expect { card.deduct(10) }.to change{ card.balance }.by(-10)
    end

    it "deducts the minimum fare" do
      minimum_fare = Oystercard::MINIMUM_FARE
      expect { card.deduct( minimum_fare) }.to change { card.balance }.by(-minimum_fare)
    end
  end
=end
  describe '#in_journey?' do
    it "checks if card is in journey" do
      expect(card).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it "changes in_journey to true" do
      card.top_up(2)
      expect(card.touch_in("station")).to eq true
    end
    it "it raises an error when less than £1" do
      expect { card.touch_in("tation") }.to raise_error 'minimum balance required'
    end
    it "stores entry station" do
      card.top_up(2)
      card.touch_in(entry_station)
      expect(card.entry_station).to include entry_station
    end
  end

  describe '#touch_out' do
    it "changes in_journey to false" do
      expect(card.touch_out).to eq false
    end
    it 'deducts minimum balance' do
      minimum_fare = Oystercard::MINIMUM_FARE
      expect { card.touch_out }.to change { card.balance }.by(-minimum_fare)
    end
  end
end
