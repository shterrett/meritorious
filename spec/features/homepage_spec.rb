require 'spec_helper'

feature 'homepage' do
  scenario 'a guest visits the homepage' do
    visit root_path
    expect(page).to have_text 'Meritorious'
  end
end
