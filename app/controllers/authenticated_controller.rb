class AuthenticatedController < ApplicationController
  before_action :authenticate_teacher!
end
