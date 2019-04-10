require 'station'

describe Station do

  let(:station) { double(:name => "name", :zone => 1) }

  context "station information" do
    it "has a name" do
      expect(station.name).to eq "name"
    end

    it "has a zone" do
      expect(station.zone).to eq 1
    end
  end
end
