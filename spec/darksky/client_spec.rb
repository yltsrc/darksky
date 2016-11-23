require "spec_helper"

describe Darksky::Client, vcr: true do
  let(:api_secret_key) { '03160617885d18d67b4b031a23510d37' }
  let(:lat) { 53.9045 }
  let(:lng) { 27.5615 }
  let(:time) { Time.new(2002, 10, 31, 2, 2, 2) }
  let(:unix_time) { time.to_i }

  subject { described_class.new(api_secret_key) }

  describe '#time_machine' do
    it 'returns data for the given time' do
      result = subject.time_machine(lat, lng, unix_time)
      expect(result["latitude"]).to eql(lat)
      expect(result["longitude"]).to eql(lng)
      expect(result["currently"]["summary"]).to eql("Mostly Cloudy")
      expect(result["currently"]["icon"]).to eql("partly-cloudy-night")
      expect(result["currently"]["precipType"]).to eql("rain")
      expect(result["currently"]["temperature"]).to eql(37.63) # Degrees Fahrenheit
      expect(result["currently"]["humidity"]).to eql(0.91) # 0 to 1
      expect(result["currently"]["windSpeed"]).to eql(3.63) # Miles per hour
      expect(result["currently"]["windBearing"]).to eql(259) # Degrees
      expect(result["currently"]["visibility"]).to eql(5.96) # Miles
      expect(result["currently"]["cloudCover"]).to eql(0.8) # 0 to 1
      expect(result["currently"]["pressure"]).to eql(1012.3) # air pressure in millibars
      expect(result["flags"]).to be_an_instance_of(Hash)
      expect(result["daily"]).to be_an_instance_of(Hash)
      expect(result["hourly"]).to be_an_instance_of(Hash)
    end

    it 'returns data for the given time with metric units' do
      result = subject.time_machine(lat, lng, unix_time, units: "si")
      expect(result["latitude"]).to eql(lat)
      expect(result["longitude"]).to eql(lng)
      expect(result["currently"]["temperature"]).to eql(3.13) # Degrees Celsius
      expect(result["currently"]["windSpeed"]).to eql(1.62) # Meters per second
      expect(result["currently"]["visibility"]).to eql(9.59) # Kilometers
    end

    it 'returns data for the given time with german language' do
      result = subject.time_machine(lat, lng, unix_time, lang: "de")
      expect(result["latitude"]).to eql(lat)
      expect(result["longitude"]).to eql(lng)
      expect(result["currently"]["summary"]).to eql("Überwiegend bewölkt")
    end

    it 'returns only currently data for the given time' do
      result = subject.time_machine(lat, lng, unix_time, exclude: "minutely,hourly,daily,alerts,flags")
      expect(result["latitude"]).to eql(lat)
      expect(result["longitude"]).to eql(lng)
      expect(result["alerts"]).to be_nil
      expect(result["flags"]).to be_nil
      expect(result["minutely"]).to be_nil
      expect(result["daily"]).to be_nil
      expect(result["hourly"]).to be_nil
    end
  end
end
