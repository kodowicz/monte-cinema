require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include FactoryBot::Syntax::Methods 

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation, except: %w(ar_internal_metadata)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # config.before :all, type: :request do
  #   create(:ticket_desk, id: 1, online: true)
  #   create(:ticket_desk, id: 2, online: false)

  #   create(:genre, id: 1, name: 'action')
  #   create(:genre, id: 2, name: 'comedy')

  #   create(:display_type, id: 1, name: '2D')
  #   create(:display_type, id: 2, name: 'IMAX')
  
  #   create(:voice_type, id: 1, name: 'original')
  #   create(:voice_type, id: 1, name: 'dubbing')
  # end

  # config.after :all, type: :request do
  #   TicketDesk.delete_all
  #   DisplayType.delete_all
  #   VoiceType.delete_all
  #   Genre.delete_all
  # end
end