module User
  class User::BaseController < ApplicationController
    before_action :authenticate_user!
  end
end

