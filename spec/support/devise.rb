RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include Devise::TestHelpers, type: :controller
  Warden.test_mode!

  config.after(:each) { Warden.test_reset! }
end
