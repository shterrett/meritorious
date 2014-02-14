module PageObject
  class Base
    include Capybara::DSL
    include Rails.application.routes.url_helpers
  end
end
