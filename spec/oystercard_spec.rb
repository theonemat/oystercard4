require 'oystercard'

describe Oystercard do

  let(:card) { described_class.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

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

  describe '#in_journey?' do
    it "checks if card is in journey" do
      expect(card).not_to be_in_journey
    end
  end

  context "travelling" do
    it "in_journey" do
      card.top_up(20)
      expect(card).not_to be_in_journey
    end
    it "touch_in" do
      card.top_up(20)
      card.touch_in(entry_station)
      expect(card).to be_in_journey
    end
    it "touch_out" do
      card.top_up(20)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it "it raises an error when less than £1" do
      expect { card.touch_in(entry_station) }.to raise_error 'minimum balance required'
    end
    it "stores entry station" do
      card.top_up(2)
      card.touch_in(entry_station)
      expect(card.entry_station).to eq entry_station
    end
  end

  describe '#touch_out' do
    it 'deducts minimum balance' do
      minimum_fare = Oystercard::MIN_FARE
      card.top_up(20)
      card.touch_in(entry_station)
      expect { card.touch_out(exit_station) }.to change { card.balance }.by(-minimum_fare)
    end
    it "resets entry station to nil" do
      expect(card.entry_station).to eq nil
    end

  end

  context '#journey_list' do
    it "is empty by default" do
      expect(card.journey_list).to eq []
    end
    it "stores a single journey" do
      card.top_up(30)
      card.touch_in("Aldgate")
      card.touch_out("Monument")
      expect(card.journey_list).to eq [{in: "Aldgate", out:"Monument"}]
    end

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
