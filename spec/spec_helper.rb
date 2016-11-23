$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "darksky"
require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    record: :new_episodes,
    re_record_interval: 60 * 60 * 24 # 1 day
  }
  config.configure_rspec_metadata!
end
