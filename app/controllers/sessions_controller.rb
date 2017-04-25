class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    raise
  end
end
