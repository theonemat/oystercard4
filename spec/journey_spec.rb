require "journey"


describe Journey  do


  context '#track' do

    it 'checks if journey is complete' do
      subject.start('Aldgate')
      expect(subject.complete?).to eq false
    end
    it 'checks if its complete before a jorney' do
      expect(subject.complete?).to eq false
    end

    it 'checksif its complete after a journey' do
      subject.start("Aldgate")
      subject.end("London")
      expect(subject.complete?).to eq true

    end

    it 'checks if journey is complete with no entry station' do
      subject.end("London")
      expect(subject.complete?).to eq false
    end

    it 'tracks entery station' do
      subject.start('Aldgate')
      expect(subject.entry_station).to eq 'Aldgate'
    end
    it 'tracks exit station' do
      subject.end('London')
      expect(subject.exit_station).to eq 'London'
    end
    it 'tracks full journey' do
      subject.start("Aldgate")
      subject.end("London")
      expect(subject.journey_full).to include(:in => "Aldgate", :out => "London")
    end
    context '#fare' do
    #   it 'deducts min fare on journey completion'
    #   subject.start("Aldgate")
    #   subject.end("London")
    #   expect(subject)
     end


  end


end
