require 'spec_helper'
require 'rake'
require 'faker'

describe 'db:seed task' do
  it 'seeds the database with valid data' do
    Meritorious::Application.load_tasks
    expect do
      Rake::Task['db:seed'].invoke
    end.not_to raise_error
  end
end
